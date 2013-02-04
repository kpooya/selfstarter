module ReferralsHelper
  def get_tweet_query_string(referring_url)
    referring_url_encoded = URI.escape(@referring_url)

    query_string = "original_referer=" + referring_url_encoded + "&text=" + URI.escape("Never Lose Any Valuables! Help make it happen for Linquet Mini. ") + referring_url_encoded + " #cool #RT";
    query_string.html_safe
  end
end
