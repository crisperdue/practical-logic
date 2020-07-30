import sys
import re

# Fixes up quotations to avoid the need for special
# parsing.  Exits status 0 if there are any quotations
# else status 1.

# Becomes True if any quotation is found.
found1 = False;

# Given a match object for the (contents of) a camlp5 quotation,
# returns an expression to expand it, applying "qx" or "qxterm" to the
# appropriate string, escaping backslashes in the string.
#
# TODO: Pick all the nits related to backslash escaping.
def fixup(match):
  global found1
  found1 = True
  text = match.group(1)
  # Multi-line matching, so $(?s).
  is_term = re.match(r'(?s)^\|(.*)\|$', text)
  if is_term: text = text[1:-1]
  escaped = escape_ocaml_string(unescape_content(text))
  func = 'parse_term ' if is_term else 'parse_fml '
  return '(' + func + escaped + ')'

# Removes escape sequences from the given quotation content.
def unescape_content(text):
  return re.sub(r'\\([\\<>])', r'\1', text)

# Escapes double quote and backslash.  Probably some others
# should be escaped, too.
def escape_ocaml_string(str):
  return '"' + re.sub(r'([\\"])', r'\\\1', str) + '"'

# Applies "fixup" to all camlp5 quotations in the given string.
# Handles the form << text >>, but not <id:< text >>.
def fixup_quotations(ss):
  # Multi-line matching, so $(?s).
  # Quotation ends at ">>" unless preceded by a single
  # backslash.
  return re.sub(r'(?s)<<(.*?)(?<![^\\]\\)>>', fixup, ss)

text = sys.stdin.read()
print(fixup_quotations(text))
sys.exit(0 if found1 else 1)
