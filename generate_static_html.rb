#!/usr/bin/ruby

puts "GENERATING STATIC HTML PAGE"
images = []
path = ENV['KIF_SCREENSHOTS']

Dir.glob("#{path}/*.png") do |image_file|
  images << image_file
end
puts "#{images.count} images found!"

          
gallery_html = ""
images.each do |image_file|
  html = "<li>
						<a class=\"thumb\" href=\"#{image_file}\" title=\"#{image_file}\">
							<img src=\"#{image_file}\" alt=\"#{image_file}\" />
						</a>
						<div class=\"caption\">
							<div class=\"download\">
								<a href=\"#{image_file}\">Download</a>
							</div>
						</div>
					</li>"
  gallery_html.concat html
end

file = File.open("template.html", "rb")
contents = file.read

to_replace = "[ruby [images]]"
contents.gsub! to_replace, gallery_html

puts "#{contents}"

out_file = File.new("index.html", "w")
out_file.puts(contents)
out_file.close
