import requests
from bs4 import BeautifulSoup
import csv

URL = "https://realpython.github.io/fake-jobs/"
page = requests.get(URL)
soup = BeautifulSoup(page.content, 'html.parser')

results = soup.find(id="ResultsContainer")
job_elements = results.find_all("div", class_="card-content")

python_jobs = results.find_all(
	"h2", string=lambda text: "python" in text.lower()
	)

python_jobs_elements = [
    h2_element.parent.parent.parent for h2_element in python_jobs
    ]

for job_element in python_jobs_elements:
	title_element = job_element.find('h2', class_="title")
	company_element = job_element.find('h3', class_="company")
	location_element = job_element.find('p', class_="location")

	link_url = job_element.find_all('a')[1]["href"]
	
	print(title_element.text.strip())
	print(company_element.text.strip())
	print(location_element.text.strip())
	print(link_url)
	print()
	


titles = list()
for title in title_element:
	titles.append(title_element.text)

companys = list()
for company in company_element:
	companys.append(company_element.text)

locations = list()
for location in location_element:
	locations.append(location_element.text)

links = list()
for link in link_url:
	links.append(link_url)

for t in zip (titles, companys, locations, links):
	print (t)

with open('./resultado.csv', 'w') as csv_file:
	csv_writer = csv.writer(csv_file, dialect='excel')
	csv_writer.writerows(zip(titles, companys, locations, links))
