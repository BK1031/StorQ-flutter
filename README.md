# StoreQ

**Mobile App**

[Manager Website](https://github.com/equinox-initiative/storq-web)

[Backend Server](https://github.com/equinox-initiative/storq-server)

## Inspiration

StorQ was inspired by a trip to Costco, by team member Thomas Liang. He went to Costco to pick up essential items during shelter in place, and when he arrived he was forced to wait outside, in a crowd with others, as the Costco in question was full of customers. Crowds like these are created by measures meant to prevent the spread of COVID19, but create situations in which those waiting to shop are at a greater risk for infection.  This experience led our team to our guiding question: ”How can we better manage the flow of customers to and from grocery stores to limit the possible spread of COVID-19, while providing a more convenient customer experience?”

## What it does

StorQ is a management app that facilitates shopping in a convenient way that reduces store congestion and prevents the spread of COVID-19. Managers begin by entering a store layout that they can customize in size as well as items in certain aisles of the store. Users start off by adding the items they want into a shopping list. We then show them store options based on their proximity from the stores, how far they are willing to travel, and the percentage of their shopping list items that the store has in stock. Once users pick a store, they enter the times they are available to go to the store. We then compare the total number of users already signed up in that time slot as well as the number of those users whose items are in the same aisles as our user (this represents how many shoppers will be shopping in a single aisle). We then mark the time slots as either green (there is space), yellow (space is limited and there may be person to person exposure), or red (the aisles are full and you cannot go at this time) if the density of shoppers in an aisle exceeds the maximum density that the aisle can have. This is calculated using the area of the aisle and the 6 feet desired spacing between people to alleviate the spread of COVID-19. In this way, we hope to provide a convenient, risk-free shopping experience for users to get the items they need while staying safe during these uncertain times.

Furthermore, if one of the customers tests positive for the coronavirus, we can alert the other people that were at the store during their time slot to also get tested, to contain the spread.

## How we built it

Both the mobile application and the manager website were built using Dart and the Flutter framework. The interactive parts of the website, such as the aisles, side bar, and store layouts are all custom Flutter widgets. We used Google Colab to develop the backend of the app/webapp system. It communicated with the Firebase database to populate and pull information. Our system included evaluating potential store trips, giving recommendations of which time slots users should sign up for, and correlating items a user might need (such as eggs) to the store product (which could be specifically free range grade AAA eggs), so that managers would know what items the store would be running out of.

## Challenges I ran into
- Managing which customers are going to which aisles and eliminating crossovers
- Had trouble with saving the locations of the aisles after reloading the page, for the manager website built in Flutter Web
- Had trouble storing multiple store trip reservations for a user
## Accomplishments that I'm proud of
- Prioritizing stores based on distance from the user, the distance they want to travel, store aisle densities, the total store populations, and the proportion of items they want that are available
- Recommending time slots based on predicted user densities in certain aisles as well as total store densities

## What I learned
- How to facilitate communication between a backend architecture and a database like Firebase
- How to utilize draggable widgets for more interactive applications in Flutter

## What's next for StorQ
In the future, we plan for this app to use machine learning technologies to predict future store densities at different days and times. We also plan to use natural language processing to make it easier for customers to search for items and image processing to allow managers and customers to scan items. It can also allow managers to monitor aisles and gather data from them. On top of that, some planned improvements to the manager app include more customizable layouts, with different kinds of aisles, as well as an improved tool for adding and updating items within a store.

## Credits
- [Bharat Kathi](https://github.com/bk1031)
  - Mobile App Development
- [Kashyap Chaturvedula](https://github.com/kashyap456)
  - Manager Website Development
- [Thomas Liang](https://github.com/ThomasLiang123)
  - Server Side Responses to User Shopping List
- [Rohan Viswanathan](https://github.com/rohanviswanathan)
  - Server Side Trip Time Slot Calculations
