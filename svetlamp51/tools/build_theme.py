"""Build the ocStore theme templates from the approved mockup.

Run from the repository root:
    python3 svetlamp51/tools/build_theme.py

The mockup svetlamp51/index.html is the source. This script writes
header.tpl and home.tpl of the svetlamp theme and svetlamp.css (through
build_css.py). Links to https://svetlamp51.ru/ become relative to the
shop's <base>, so the theme works on http and https alike.
"""
import os, re, subprocess, sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MOCK = os.path.join(ROOT, 'index.html')
TOOLS = os.path.join(ROOT, 'tools')
THEME = os.path.join(ROOT, 'ocstore/upload/catalog/view/theme/svetlamp')
SITE = 'https://svetlamp51.ru/'

s = open(MOCK, encoding='utf-8').read()


def between(a, b, start=0):
    i = s.index(a, start)
    return s[i:s.index(b, i)]


def shop(html):
    # Our buttons are .sl-btn: Bootstrap 3 in the shop already owns .btn
    html = re.sub(r'class="btn ([^"]*)"',
                  lambda m: 'class="sl-btn ' + ' '.join('sl-' + t if t.startswith('btn-') else t for t in m.group(1).split()) + '"',
                  html)
    # Shop links relative to <base href="https://svetlamp51.ru/">
    return html.replace('href="' + SITE, 'href="').replace('data-href="' + SITE, 'data-href="')


# ---------- header.tpl ----------
head = open(os.path.join(TOOLS, 'theme_head.tpl'), encoding='utf-8').read()
sprite = s[s.index('<svg width="0" height="0"'):s.index('</svg>', s.index('</defs>')) + 6]
topbar = between('<div class="topbar">', '<!-- Header -->').rstrip() + '\n'
header = between('<header class="header">', '<main>').rstrip() + '\n'
header = header.replace('<a class="logo" href="#"', '<a class="logo" href="<?php echo $home; ?>"')
# The shop's own search box (common/search.tpl) takes the place of the mockup form
form = header[header.index('    <form class="search"'):header.index('</form>') + len('</form>')]
header = header.replace(form, '    <?php echo $search; ?>')
directions = between('<!-- Directions -->', '<!-- Hero -->').rstrip() + '\n'
header_tpl = (head + '<div class="sl sl-top">\n' + sprite + '\n\n' + topbar + '\n' + shop(header) + '\n' + shop(directions) + '</div>\n')
for bad in ('<form', 'suggest', 'class="btn '):
    assert bad not in header_tpl, bad
open(os.path.join(THEME, 'template/common/header.tpl'), 'w', encoding='utf-8').write(header_tpl)

# ---------- home.tpl ----------
hero = between('<!-- Hero -->', '<!-- Catalog -->')
catalog = between('<!-- Catalog -->', '<!-- Socket picker -->')
sockets = between('<!-- Socket picker -->', '<!-- Recommended -->')
showroom = between('<!-- Showroom -->', '</main>')
recommended = open(os.path.join(TOOLS, 'theme_recommended.tpl'), encoding='utf-8').read()

showroom = showroom.replace('<p class="lead">', '<p class="lead showroom-lead">')

fit = '''<script>
/* Size the hero before the first paint; svetlamp.js keeps it in step on resize */
(function () { var h = document.querySelector('.sl .hero'); if (!h) return; var a = Math.round(h.getBoundingClientRect().top + window.scrollY); document.documentElement.style.setProperty('--above', a + 'px'); h.style.height = (window.innerHeight - a) + 'px'; })();
</script>

'''
home_tpl = ('<?php echo $header; ?>\n'
            '<?php if (!isset($sl_recommended)) $sl_recommended = array(); // set by the SvetLamp home controller ?>\n'
            '<main class="sl sl-home">\n'
            + shop(hero) + fit + shop(catalog) + shop(sockets) + recommended + shop(showroom)
            + '</main>\n<?php echo $footer; ?>\n')
assert 'class="btn ' not in home_tpl
open(os.path.join(THEME, 'template/common/home.tpl'), 'w', encoding='utf-8').write(home_tpl)

# ---------- svetlamp.js ----------
script = s[s.rindex('<script>') + 8:s.rindex('</script>')]


def block(title):
    a = script.index('/* ---------- ' + title)
    return script[a:script.index('})();', a) + 5]


# Each part checks that its element exists: the header and footer appear on every page, the rest only on the home page
parts = [
    block('Hero fits').replace("  const hero = document.querySelector('.hero');\n", "  const hero = document.querySelector('.sl .hero');\n  if (!hero) return;\n"),
    block('Colour temperature').replace("  const input = document.getElementById('kelvin');\n", "  const input = document.getElementById('kelvin');\n  if (!input) return;\n"),
    block('Sockets').replace("  const card = document.querySelector('.socket-card');\n", "  const card = document.querySelector('.socket-card');\n  if (!card) return;\n"),
    block('Catalog panel').replace("  const panel = document.getElementById('catpanel');\n", "  const panel = document.getElementById('catpanel');\n  if (!btn || !panel) return;\n"),
    block('Reveal on scroll'),
]
for p in parts[:4]:
    assert 'return;' in p
open(os.path.join(THEME, 'javascript/svetlamp.js'), 'w', encoding='utf-8').write(
    '/* SvetLamp theme: hero sizing, colour temperature, socket picker, catalog panel, scroll reveal. */\n\n' + '\n\n'.join(parts) + '\n')

# ---------- svetlamp.css ----------
subprocess.check_call([sys.executable, os.path.join(TOOLS, 'build_css.py'), MOCK,
                       os.path.join(THEME, 'stylesheet/svetlamp.css')])
print('header.tpl, home.tpl, svetlamp.js and svetlamp.css rebuilt from', MOCK)
