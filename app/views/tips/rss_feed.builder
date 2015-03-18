xml.instruct! :xml, version: '1.0' 
xml.rss version: '2.0' do
  xml.channel do
    xml.title 'Tips on Rails'
    xml.description "We created Tips on Rails for Rails enthusiasts to share their tips about everything Rails (and Ruby). It's built and run by you. With your help, we're working together to build a library of detailed tips about every aspect of Rails (and Ruby) development."
    xml.link tips_url

    @tips.each do |tip|
      xml.item do
        xml.title tip.title
        xml.description tip.description
        xml.pubDate tip.created_at.to_s(:rfc822)
        xml.link tip_url(tip)
        xml.guid tip_url(tip)
        xml.author tip.user.name
      end
    end
  end
end