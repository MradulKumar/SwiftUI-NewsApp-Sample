Demo - News App (iOS)

Platform - iOS 
Frameworks Used - SwiftUI, URLSession, Foundation
Architecture - MVVM
Testing - XCTest Framework 
Rest API Provider - News API (Free Account)
Rest API Provider Website - https://newsapi.org/



Project Overview - 
This app News is built for the iOS platform using swift ui. This app can be used to get the news from api and displays the data on the view. 
The rest api request gets the data from newsapi.org server in JSON format and parses the data for the usage. You can select the news to view it in detail.


Flow of the app -
1. On launch, the app fetches the data from 'newsapi.org' servers.
2. The fetched data is shown on UI in a list
3. On tap of an item in the list, you can see the detailed news. 
4. On the detail page, you can select button "More Details" to open the link in web browser
5. On the launch only 20 records are fetched, rest are fetched using paging
6. "Pull To Refresh" for the new contents 

Testing - I tried to cover mock network manager tests.

Further Improvements - Which can be done
1. The response can be cached to use in offline mode
2. UI can be more good, i have created a basic one






