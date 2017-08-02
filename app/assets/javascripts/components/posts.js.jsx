var Posts = React.createClass({

  render: function() {
    posts = this.props.posts.map( function(post) {
      return (
        <Post post={post} key={post.id} />
      );
    });
    return (
      <div>
        <h4>
          Welcome to Edgar Shuffle!
        </h4>
        <p>
          Edgar Shuffle is a small app intended to demonstrate the 
          shuffling and un-shuffling of queue content by category.  
        </p>
        <p>
          To try it out:
        </p>
        <ol>
          <li>
            Take a look at the sample queue below
          </li>
          <li>
            Shuffle or un-shuffle a category from the categories page
          </li>
          <li>
            You'll be sent back here to see how the queue has changed &ndash; that's it!
          </li>
        </ol>
        <h2> 
          Queue
        </h2>
        <div id="posts">
          {posts}
        </div>
      </div>
    );
  }
});