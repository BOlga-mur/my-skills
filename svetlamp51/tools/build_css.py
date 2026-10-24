"""Turn the mockup's stylesheet into svetlamp.css that lives safely beside Bootstrap 3 and the ocStore stylesheet."""
import re, sys
src = open(sys.argv[1]).read()
css = src[src.index('<style>') + 7:src.index('</style>')]

# 1. Base rules: replaced by scoped versions written below.
base_start = css.index('*, *::before, *::after')
base_end = css.index('.wrap {')
css = css[:base_start] + css[base_end:]

# 2. Drop the mockup's search suggestions (the shop has its own search).
css = re.sub(r'\.suggest[^{]*\{[^}]*\}\n', '', css)

# 3. Rename our button class so it never meets Bootstrap's .btn.
css = re.sub(r'\.btn(?![\w-]*-btn)\b', '.sl-btn', css)
css = css.replace('.showroom .lead', '.showroom .showroom-lead')

# 4. Bootstrap sets html to 10px, so rem would shrink everything: use px.
def rem(m):
    v = float(m.group(1)) * 16
    return ('%g' % round(v, 2)) + 'px'
css = re.sub(r'(\d*\.?\d+)rem\b', rem, css)

# 5. Prefix every selector with .sl so the rules apply only inside our blocks.
def prefix_sel(sel):
    s = sel.strip()
    if not s or s.startswith((':root', 'html', 'body', '*')):
        return s
    if s.startswith('.js '):
        return '.js .sl ' + s[4:]
    return '.sl ' + s

def process(text):
    out, i = [], 0
    while i < len(text):
        j = text.find('{', i)
        if j < 0:
            out.append(text[i:]); break
        head = text[i:j]
        # find matching brace
        depth, k = 1, j + 1
        while depth:
            if text[k] == '{': depth += 1
            elif text[k] == '}': depth -= 1
            k += 1
        body = text[j + 1:k - 1]
        lead = head[:len(head) - len(head.lstrip())]
        h = head.strip()
        # keep comments that sit before a selector
        comment = ''
        while h.startswith('/*'):
            e = h.index('*/') + 2
            comment += h[:e] + '\n'
            h = h[e:].strip()
        if h.startswith('@media') or h.startswith('@supports'):
            out.append(lead + comment + h + ' {' + process(body) + '}')
        elif h.startswith('@'):
            out.append(lead + comment + h + ' {' + body + '}')
        else:
            sels = ', '.join(prefix_sel(x) for x in h.split(','))
            out.append(lead + comment + sels + ' {' + body + '}')
        i = k
    return ''.join(out)

css = process(css)

base = '''
/* Base: only inside our blocks (.sl), so the shop's inner pages keep Bootstrap's look */
body.sl-body { font-family: var(--font); -webkit-font-smoothing: antialiased; overflow-x: hidden; }
body.sl-body h1, body.sl-body h2, body.sl-body h3, body.sl-body h4, body.sl-body h5, body.sl-body h6 { font-family: var(--font); }
body.common-home { background: var(--bg); }
.sl { font-family: var(--font); font-size: var(--step-body); line-height: 1.55; color: var(--ink); font-feature-settings: "tnum" 0; }
.sl *, .sl *::before, .sl *::after { box-sizing: border-box; }
.sl img, .sl svg { display: block; max-width: 100%; }
.sl a { color: inherit; text-decoration: none; }
.sl a:where(:hover, :focus) { color: inherit; text-decoration: none; }
.sl a:focus:not(:focus-visible), .sl button:focus:not(:focus-visible), .sl input:focus:not(:focus-visible) { outline: none; }
.sl button, .sl input { font: inherit; color: inherit; margin: 0; }
.sl h1, .sl h2, .sl h3, .sl h4 { margin: 0; font-family: inherit; color: inherit; font-weight: 600; letter-spacing: -0.02em; line-height: 1.08; text-wrap: balance; }
.sl p { margin: 0; text-wrap: pretty; }
.sl ul, .sl ol { margin: 0; padding: 0; list-style: none; }
.sl dl { margin: 0; }
.sl dt { font-weight: 400; }
.sl dd { margin: 0; }
.sl label { font-weight: inherit; margin: 0; }
.sl output { display: inline; padding: 0; color: inherit; }
.sl :focus-visible { outline: 3px solid var(--accent); outline-offset: 3px; border-radius: 4px; }
.sl ::selection { background: var(--accent); color: var(--accent-ink); }
.sl .visually-hidden { position: absolute !important; width: 1px; height: 1px; overflow: hidden; clip: rect(0 0 0 0); white-space: nowrap; }
.sl #search { margin-bottom: 0; }
.sl .footer { margin: 0; border: 0; }
/* Shop pages: the header band keeps its own ground on white inner pages */
.sl.sl-top { background: var(--bg); }
/* The shop sells in the showroom. Modules (Купить в 1 клик, cart) insert buy buttons on their own,
   through OCMOD or script, into any theme: keep every one of them hidden, on every page */
#button-cart, #cart, .btn.order, button.order, .button.order, [data-target="#order"], #order.modal,
button[onclick*="cart.add"], input[onclick*="cart.add"] { display: none !important; }
/* Product photos from the shop sit on the card's ground; white photo backgrounds blend in */
.sl .card-pic img { width: 100%; height: 100%; object-fit: contain; mix-blend-mode: multiply; }
'''
root_end = css.index('}', css.index(':root')) + 1
css = css[:root_end] + '\n' + base + css[root_end:]
header = '/* SvetLamp theme for ocStore 2.3. Built from the approved mockup (svetlamp51/index.html). */\n'
open(sys.argv[2], 'w').write(header + css.lstrip())
