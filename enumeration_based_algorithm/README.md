### Summary

Here, I tried to use an **enumerator to pick through the HTML tags** on the premise that I would be able to `peek` ahead and insert the `target='blank` string. Once I realized the **obvious fact** that once the enumerator gets going, there is **no way for me to insert the string at the appropriate place** without referring back to the original file and inserting it into there, I was continuing with the algorithm merely for the challenge.

### Implementation

The implementation, although **admittedly messy**, can be done quite easily by building a more complex enumerator with `each_char.with_index`. This means I can access the index in the string of HTML where the approriate insertion point is, and also keep a reference to the current char captured by the enum.

This method of inserting `target='blank'` actually **works** - but **only for one insertion**. Once you insert one `target=blank`, this mutates the `size` of original file (the array of chars) and therefore for any subsequent insertion, you have to take into account the current offset in comparison to the original set of chars in the enum.

Again, this can be done quite easily done with the following line:

```ruby
  @indices.each_with_index do |file_idx, idx|
    @file.insert(file_idx + (idx * HTML_INSERT.size), HTML_INSERT)
  end
```

### Unscientific Benchmarks:

During my benchmarks it takes roughly 1.4 - 1.5 seconds to parse through the given `document.html` 20 times. (this document is messy and unrealistic in terms of the number of linkes for the average web page), but it provides a good upper bound.

I'd calculate the **worst-case complexity to be O(N)**. It is difficult to significantly improve upon this - without an external library - owing to the fact that I'm searching for very specific strings within the document. However, I will try again with a different approach and hopefully improve upon the benchmark for this algorithm.

### What I Learned

As a beginner, sometimes you need to go against best practices to **feel the pain**, and truly understand why certain best practices such as TDD exist. Had I used TDD whilst constructing this algorithm, I believe I **would have realized even sooner that enumeration was not going to be the optimal method of parsing in this situation** - at least not with my current knowledge.

Although, I feel slightly embarassed sharing this attempt, I think it has been an important step in improving both my knowledge as a whole and my patience in problem solving.





