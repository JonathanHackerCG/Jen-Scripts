*Jen-Scripts uses grids to store values that correspond to 2-dimensional terrain. The functions in this asset are used to change and shape the values in the grid. The data inside the grid can be anything you’d like including objects, numbers, text, structs, etcetera. However, to transform the grid data into terrain, you will need to instantiate the grid, treating the data inside as either objects or tilemap data.*

*Jen-Scripts does not generate terrain for you. You will need to use the functions provided to 'describe' the terrain you want. This section of the documentation deals with the fundamentals of using Jen-Scripts, including creating a new grid for use with terrain generation, instantiating your terrain, and other functions which are helpful to know throughout the entire process of programming your terrain generation. Later sections cover how to take the basics and actually produce procedurally generated content.*

*Talk about replace and new_value parameters, because they are everywhere.*

*Add a page for function parameter, because they are also quite frequent.*

*Talk about how Jen-Scripts handles string, such as ignoring them when instantiating.*

## Replace/New Value Parameters

## Setter Parameter

## Performance
The goal for Jen-Scripts is flexibility and readability. Very little effort was put into performance, and any optimizations beyond writing clean code are out of scope for this project. By necessity of its flexibility, Jen-Scripts iterates through every cell in the grid for every line, even those that could be combined into a single iteration. It performs many extra checks to support optional parameters.

This means that Jen-Scripts is only well suited for small-scale terrain generation. At larger grid sizes and complex terrain you will notice performance impacts. If you run into this:
1) Use Jen-Scripts only in chunks over multiple frames.
2) Don't use Jen-Scripts. Though, feel free to use Jen-Scripts as a template.

If anyone happens to notice performance gains possible without sacrificing any features or robust error checking, feel free to write me a pull request. I'm sure they exist, and would not mind including them, but it's not my focus.