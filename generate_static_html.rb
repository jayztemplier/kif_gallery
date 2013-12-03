#!/usr/bin/ruby

puts "GENERATING STATIC HTML PAGE"

path = ENV['KIF_SCREENSHOTS']
root_path = File.expand_path File.dirname(__FILE__)
Dir.chdir(root_path)

img_dir = root_path+"/img"
puts "Image directory : #{img_dir}"
puts "Screenshots directory : #{path}"

puts %x[rm -rf #{img_dir}]
puts %x[mkdir #{img_dir}]
puts %x[cp -R $KIF_SCREENSHOTS/* #{img_dir}]

images = []
puts "Current dir : #{Dir.pwd}"
Dir.glob("img/*") do |image_file|
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

