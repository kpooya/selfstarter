module RewardsHelper
  def like_button(width = 70, show_faces = false)
    raw "<div class='fb-like' data-href='#{LINQUET_MINI_URL}' data-send='false' data-layout='button_count' data-width='#{width}' data-show-faces='#{show_faces}'></div>"
  end

  def pin_it_button
    image_url = URI.encode("#{request.scheme}://#{request.host}#{image_path(Settings.product_image_url)}")
    raw "<a href='http://pinterest.com/pin/create/button/?url=#{encoded_root_url}&media=#{image_url}' class='pin-it-button' count-layout='vertical'><img border='0' src='//assets.pinterest.com/images/PinExt.png' title='Pin It' /></a>"
  end

  def tweet_button
    #TODO @order_number = 5
    #tweet_text = "I'm #{Settings.primary_stat_verb} number #{number_with_delimiter @order_number, :delimiter => ","} #{Settings.tweet_text}!"
    tweet_text = "Never Lose Your Phone, Keys or Pet Again! Help make it happen for Linquet Mini #{LINQUET_MINI_URL} #cool #RT"
    raw "<a href='https://twitter.com/share' data_url='#{LINQUET_MINI_URL}' class='twitter-share-button' data-text='#{tweet_text}'>Tweet</a>"
  end

  def google_plus_button
    # Place this tag where you want the +1 button to render.
    gp_button = raw  "<div class='g-plusone' data-size='medium' data-href='#{LINQUET_MINI_URL}'></div>"
  end

  def video_embed_url(autoplay=false)
    autoplay_bit = (autoplay)? "1" : "0"
    ("#{Settings.video_bare_url}?" + case Settings.video_bare_url
    when /vimeo/
      'title=0&byline=0&portrait=0&autoplay=' + autoplay_bit
    when /youtube/
      'autohide=1&showinfo=0&rel=0&autoplay=' + autoplay_bit
    else
      ''
    end).html_safe
  end

  def encoded_root_url
    raw URI.encode "#{request.scheme}://#{request.host}/rewards"
  end
end
