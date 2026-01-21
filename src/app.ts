import { tokenize } from './tokenizer.ts';
import { parse, type Statement } from './parser.ts';
import { generate } from './generator.ts';


const sources: [string, string][] = [
    ['musicology', 'Musicology'],
    ['pomo', 'Postmodern'],
    ['securities', 'Finance Company Names'],
    ['crackpot', 'Crackpot'],
    ['manifesto', 'Manifesto'],
    ['sample', 'Testing File'],
    ['legal', 'Random Legalese'],
];

const titleSuffix = 'New Musicology Essay Generator (Javascript) - MSAC'

const select = document.createElement('select');
select.id = 'source-select';
// Populate the dropdown
for (const [file, label] of sources) {
  const option = document.createElement('option');
  option.value = `scripts/${file}.pb`;
  option.textContent = label;
  select.appendChild(option);
}
document.body.appendChild(select);

select.addEventListener('change', () => {
  const file = select.value;
  history.replaceState(null, '', `?file=${encodeURIComponent(file)}`);
  loadAndRender(file).catch(console.error);
});

const params = new URLSearchParams(location.search);
const file = params.get('file') ?? 'scripts/musicology.pb';
select.value = file;

async function loadAndRender(fileUrl: string) {
  try {
    const res = await fetch(fileUrl);
    const text = await res.text();
    if (text.trim().startsWith('<')) {
      // noinspection ExceptionCaughtLocallyJS
      throw new Error(`Expected .pb file, got HTML instead (from ${fileUrl})`);
    }
    const tokens = tokenize(text);
    const statements: Statement[] = parse(tokens);
    const first = statements.find(s => s.type === 'rule' && !s.resource);
    const entry = first && first.type === 'rule' ? first.name : 'main';
    const html = generate(statements, entry, 'html');
    document.body.innerHTML = html;
    document.body.appendChild(select);
  } catch (err) {
    document.body.innerHTML = `<pre>Error: ${(err as Error).message}</pre>`;
    document.body.appendChild(select);
  }
  const titleElement = document.querySelector('h1.title');
  if (titleElement) {
      document.title = titleElement.textContent + ' -- ' + titleSuffix;
  }
}

loadAndRender(file).catch(console.error);
