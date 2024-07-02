# frozen_string_literal: true

[
  {
    title: 'A Comprehensive Guide to Article Searching',
    content: "When searching for articles, it's crucial to use a variety of keywords and filters to narrow down results effectively.
      Be mindful of the sources you choose, opting for reputable journals or databases to ensure the reliability of the information you find.
      Additionally, saving relevant articles and citing them properly can streamline your research process and add credibility to your work."
  },
  {
    title: '10 Tips for Optimizing Your Article Search',
    content: "Use Specific Keywords: Utilize precise keywords related to your topic for better search results.
      Filter by Date: Narrow down results by specifying a date range to find the most recent and relevant articles.
      Utilize Advanced Search Tools: Take advantage of advanced search options provided by search engines to refine your results.
      Applying these tips can help streamline your article search process and ensure you find the most relevant information efficiently."
  },
  {
    title: 'Exploring the Benefits of Article Searching',
    content: 'Article searching offers numerous advantages.
      It allows researchers to access a wide range of sources quickly.
      This can save time and provide a comprehensive view of a topic.
      Additionally, article searching enables users to find up-to-date information on specific subjects. 
      This can be crucial for staying informed and conducting thorough research.'
  }
].each do |article|
  Article.find_or_create_by(title: article[:title], content: article[:content])
end
