Bundler.require(:api)
Treetop.load File.expand_path(Rails.root.join('lib/api/grammar/codecs'))
Treetop.load File.expand_path(Rails.root.join('lib/api/grammar/definitions'))
Treetop.load File.expand_path(Rails.root.join('lib/api/grammar/standard'))
parser = StandardParser.new

ss = []
ss << "[Zero-Raws] JoJo no Kimyou na Bouken - 02 (MX 1280x720 x264 AAC).mp4"

ss.each do |s|
  s.force_encoding('UTF-8')
  puts API::Release.build(s, parser.parse(s))
end
