# Shopify Wintership 2017 'Shopicruit' Task

## How to run
Enter the following command below into command line (when in root of project directory):

`make run f=<URL>`

URL is the web address of the JSON file
In particular, this was used: http://shopicruit.myshopify.com/products.json?limit=250

Note:
- I noted that there was only 5 pages of products with 50 per page
- Since there were only 250 products '?limit=250' was appended into the URL

## How it works
The lexer separates the JSON file into tokens and the parser builds a parse tree for it

The parse tree is traversed using the listener method and flags are set when each product is encountered
If the right flags are set the price is totalled

Currently, flags are only set if "Watch" or "Clock" product types are encountered and each variant is available

This code was written in Java using IntelliJ with the ANTLRv4 Plugin

## Possible improvements
- Implement reading pages of the shopify JSON

## Why not just use JSON library
I recently learned about parser generators and wanted to practice using one to solve a problem

## What external libraries are used
ANTLR v4

## What's needed to compile
ANTLR v4 which can be installed using this guide https://webdocs.cs.ualberta.ca/~c415/Setup/

## Credits
Makefile made by Marcus Karpoff