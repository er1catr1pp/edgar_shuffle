var Categories = React.createClass({

  render: function() {
    categories = this.props.categories.map( function(category) {
      return (
        <Category category={category} key={category.id} />
      );
    });
    return (
      <div>
        <p>
          Shuffle or un-shuffle any category: 
        </p>
        <ul>
          <li>
            Shuffling will randomize content in the queue
          </li>
          <li>
            Un-shuffling will return content to last-in first-out order in the queue.
          </li>
        </ul>
        <h2>Categories</h2>
        <div id="categories">
          {categories}
        </div>
      </div>
    );
  }
});