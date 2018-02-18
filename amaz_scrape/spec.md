# Specifications for the CLI Assessment

Specs:
- [x] Have a CLI for interfacing with the application
    User can start the gem directly from the terminal. The entire interaction provides instructions, asks for input, and provides output from the command line.
- [x] Pull data from an external source
    The project takes data from Amazon based on a user supplied product. The user can change this product and search a new one if they choose.
- [x] Implement both list and detail views
    The gem will scrape the first 10 results and display them in a list. It will then allow the user to pick one of those elements to get more information about. The user can then go back to the list and select another item or they can enter a new product to search.