#!/usr/bin/ruby

puts "GENERATING STATIC HTML PAGE"
images = []
path = ENV['KIF_SCREENSHOTS']
root_path = File.expand_path File.dirname(__FILE__)

%x[rm -rf img]
%x[cp -R $KIF_SCREENSHOTS img]

Dir.glob("img/*.png") do |image_file|
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

file = File.open(root_path + "/template.html", "rb")
contents = file.read

to_replace = "[ruby [images]]"
contents.gsub! to_replace, gallery_html

out_file = File.new(root_path + "/index.html", "w")
out_file.puts(contents)
out_file.close

