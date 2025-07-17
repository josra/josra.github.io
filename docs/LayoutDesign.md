### General Layout
The layout is made up of 2 major parts, we have the menu part which is the top part of the page.
The second part is the page content itself which contain the different content from each subsite.
The whole page layout is made with bootstrap, which makes this super simple and smart.

## Header / Menu
This menu is split in 2 parts, we have the Logo and the menu part itself.

# Logo
This part is defined as `col-md-4` which gives it 4 of the bootstrap columns and makes sure that it always has this realestate.
That is important if we want to make sure that the website also looks good everywhere between fullsize screen and mobile.
The logo itself is defined with the bootstrap class `.img-responsive` which takes care of all the "responsiveness" needed.

# Menu
This part is defined as `col-md-8` and it has works the same as Logo but just 8 columns

## Content / Sidebar

# Sidebar
This part takes up the same as the Logo which is `col-md-4`
this can contain either sublinks to different subpages, twitter-feed and Praqma ads. there is possiblity to put in other thing.

# Content
This part takes up the same as the menu which is `col-md-8` with this we get a unified look. 
this part contains the main content for the specific page.

### Code dump and examples

# page

```
<!DOCTYPE html>

<html>
  {%include head.html%}
  <body>
    <div id="main_container">
      {%include banner.html%}
      <div class="row">
        <div class="side_container">
            {%include twitter-sidebar.html%}
        </div>
        <div class="content_container">
          {{ content }}
        </div>
      </div>
    </div>
  </body>
  
</html>

```
this is the most common way to make a page.

Start off by setting the doctype `HTML`
the give it a <body> tag
when this is done you can now implement the 4 elements.

1. We have an `<div>` which has the ID `main_container` this makes sure that we dont use the whole screen realestate,
but instead get a bit more narrow view which makes the reading and use of the page alot better. It's very important
that you place the `banner.html` as the first element in this `<div>` (Note: this should be remade so the banner is automaticly implemented)

2. Here we have another `<div>` which has the CLASS `row` this is a standard bootstrap class that strips all padding and takes up the full width of the parent DOM.

3. Next we have a `<div>` which is labeled with the CLASS `side_container` as the name stated this is the sidebar we have.
the reason why this is written first is to make sure that its placed on the left side of the page. this `<div>` can contain any `include or html`

4. we have the last `<div>` which is the main content of the page and it uses the CLASS `content_container` all this `<div>` contains is the content loaded from the specific MD file



