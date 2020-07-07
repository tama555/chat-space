$(function(){


  function buildHTML(message){
    if ( message.image ) {
      let html =
        `<div class="message" data-message-id=${message.id}>
          <div class="message__box">
            <div class="messege__box--name">
              ${message.user_name}
            </div>
            <div class="message__box--data">
              ${message.created_at}
            </div>
          </div>
          <div class="message__text">
            <p class="message__text--main">
              ${message.content}
            </p>
            <img class="Message__image" src="${message.image}">
          </div>
        </div>`
      return html;
    } else {
      let html =
      `<div class="message" data-message-id=${message.id}>
        <div class="message__box">
          <div class="messege__box--name">
            ${message.user_name}
          </div>
          <div class="message__box--data">
            ${message.created_at}
          </div>
        </div>
        <div class="message__text">
          <p class="message__text--main">
            ${message.content}
          </p>
        </div>
      </div>`
      return html;
    };
  }

  $('.Form').on('submit', function(e){
    e.preventDefault();
    let formData = new FormData(this);
    let url = $(this).attr('action');
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      let html = buildHTML(data);
      $('.Main-chat__message--list').append(html);      
      $('form')[0].reset();
      $('.Main-chat__message--list').animate({ scrollTop: $('.Main-chat__message--list')[0].scrollHeight});
      $('.send-box').attr('disabled', false);
    })
    .fail(function() {
      alert("メッセージ送信に失敗しました");
      $('.send-box').attr('disabled', false);
    });
  });
});