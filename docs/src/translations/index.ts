import af from "./af.json";
import ar from "./ar.json";
import ca from "./ca.json";
import cs from "./cs.json";
import da from "./da.json";
import de from "./de.json";
import el from "./el.json";
import en from "./en.json";
import es from "./es.json";
import fi from "./fi.json";
import fr from "./fr.json";
import he from "./he.json";
import hi from "./hi.json";
import hu from "./hu.json";
import id from "./id.json";
import it from "./it.json";
import ja from "./ja.json";
import ko from "./ko.json";
import nl from "./nl.json";
import no from "./no.json";
import or from "./or.json";
import pl from "./pl.json";
import pt from "./pt.json";
import ptBR from "./pt-br.json";
import ro from "./ro.json";
import ru from "./ru.json";
import sr from "./sr.json";
import sv from "./sv.json";
import th from "./th.json";
import tr from "./tr.json";
import uk from "./uk.json";
import vi from "./vi.json";
import zh from "./zh.json";
import zhHant from "./zh-hant.json";

const locales = {
  af,
  ar,
  ca,
  cs,
  da,
  de,
  el,
  en,
  es,
  fi,
  fr,
  he,
  hi,
  hu,
  id,
  it,
  ja,
  ko,
  nl,
  no,
  or,
  pl,
  pt,
  "pt-BR": ptBR,
  ro,
  ru,
  sr,
  sv,
  th,
  tr,
  uk,
  vi,
  zh,
  "zh-Hant": zhHant,
};
const translations: Record<string, Record<string, string>> = {};

for (const [lang, dictionary] of Object.entries(locales)) {
  for (const [key, term] of Object.entries(dictionary)) {
    translations[key] = { ...translations[key], [lang]: term };
  }
}

export function getTranslations(
  key: string
): Record<string, string> | undefined {
  return translations[key];
}

export function toSnakeCase(str: string): string {
  return str
    .replace(/\s+/g, " ") // Replace multiple spaces with a single space
    .trim() // Trim leading and trailing spaces
    .toLowerCase() // Convert to lowercase
    .replace(/\s/g, "_"); // Replace spaces with underscores
}

export function getSidebarTranslatedLabel(key: string): {
  label: string;
  translations: Record<string, string> | undefined;
} {
  return {
    label: key,
    translations: getTranslations(toSnakeCase(key)),
  };
}
