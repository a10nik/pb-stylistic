
#%% 
import pandas as pd
import os
import requests
from lxml import html
from collections import defaultdict
import time

#%%

failed = []
collection = []

authors = defaultdict(lambda: len(authors))
book_num = 0

book_url = 'https://flibusta.appspot.com/b/'
i = 0
for filename in sorted(os.listdir('./fb2')):

    if filename.endswith('.fb2.zip'):
        fbusta_id = filename.split(".")[-3]
        i+= 1
    # elif filename.endswith('djvu'):
    #     fbusta_id = filename.split(".")[-2]
    else:
        continue

    if i % 100 == 0:
        time.sleep(60)
    
    try:
        response = requests.get(book_url+fbusta_id)
        assert response.status_code == 200
        tree = html.fromstring(response.text)
        section = tree.xpath('//div[@id="main"]')[0]
        size = section.xpath('//span[@style="size"]')[0].text_content()
        size_pages = size.split(',')[-1].split()[0]
        # title = section[2].text_content()
        title = section.xpath('//h1[@class="title"]')[0].text_content()
        # author = section[4].text_content()
        for link in section.iterlinks():
            if link[2].startswith('/a/') and not link[2].startswith('/a/all'):
                author = link[0].text_content()
                break
        surname = author.rsplit(' ', 1)[-1]
        names = author.rsplit(' ', 1)[0]
        if title.endswith('(fb2)'):
            title = title[:-6]
        elif title.endswith('(djvu)'):
            title = title[:-7]
        print(fbusta_id, 'successful')
        print(book_num, surname, names, title, size_pages)
        
        book_num += 1
        author_id = authors[author]
        book_id = book_num
        collection.append({
                "fbusta_id": fbusta_id,
                "book_title": title,
                "author_name": names,
                "author_surname": surname,
                "book_id": book_id,
                "author_id": author_id,
                "size": size_pages
        })
    except:
        print()
        print(fbusta_id, "==FAILED==, status code:", response.status_code)
        print()
        failed.append(fbusta_id)


#%%
failed

#%%
collection_catalog = pd.DataFrame(collection)
collection_catalog.to_csv("collection_catalog.csv", sep=';', index=False)
