import re
from bs4 import BeautifulSoup
html_doc = open("Presidential Approval for President Obama.html", "r").read()
html_doc = re.sub("iso-8859-1", "utf-8", html_doc)
soup = BeautifulSoup(html_doc)
soup.find("div", id = "editablecontent").find_all("table")[13].prettify()

