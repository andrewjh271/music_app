module ApplicationHelper
  def auth_token
    "<input
        type='hidden'
        name='authenticity_token'
        value='#{form_authenticity_token}'
      >".html_safe
  end

  def patch
    "<input
      type='hidden'
      name='_method'
      value='PATCH'>".html_safe
  end

  def lyrics_display(lyrics)
    stanzas = lyrics.split(/\n/)
    html = '<i>'

    stanzas.each do |stanza|
      if stanza.match?(/^\r/)
        html << "<br>"
      else
        html << "<div> #{h(stanza)} </div>"
      end
    end
    html << '</i>'
    html.html_safe
  end
end
