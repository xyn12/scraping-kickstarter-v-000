require 'nokogiri'

def create_project_hash
	projects = {}
	kickstarter = Nokogiri::HTML(File.read('fixtures/kickstarter.html'))

	kickstarter.css('li.project.grid_4').each do |project|
		title = project.css('h2.bbcard_name strong a').text

		projects[title.to_sym] = {
			image_link: project.css('img.projectphoto-little').attribute('src').value,
			description: project.css('p.bbcard_blurb').text,
			location: project.css('span.location-name').text,
			percent_funded: project.css('li.first.funded strong').text.gsub('%', '').to_i
		}
	end

	projects
end