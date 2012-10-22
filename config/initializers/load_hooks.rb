ActiveSupport.on_load(:grabber) do
  Bundler.require(:api)
  Dir[Rails.root.join('lib/api/grammar/**/*.treetop')].sort.each do |grammar|
    Treetop.load grammar.gsub(/\.treetop$/, '')
  end
end
