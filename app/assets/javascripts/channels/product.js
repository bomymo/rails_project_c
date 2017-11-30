App.product = App.cable.subscriptions.create("ProductChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    $(".alert.alert-info").show();
    $('.product-reviews').prepend(data.comment);
    $("#average-rating").attr('data-score', data.average_rating);
    refreshRating();
  },

  listen_to_comments: function() {
    console.log("listen to comments");
    return this.perform('listen', {
      product_id: $("[data-product-id]").data("product-id")
    });
  }
});

$(document).on('turbolinks:load', function() {
  console.log("product.js turbolinks");
  App.product.listen_to_comments();
});
