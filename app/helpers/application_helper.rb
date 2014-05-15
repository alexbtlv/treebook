module ApplicationHelper

	def bootstrap_paperclip_picture(form, paperclip_object)
		if form.object.send("#{paperclip_object}?")
			content_tag(:div, class: 'control-group') do
				content_tag(:label, "Current #{paperclip_object.to_s.titleize}", class: 'control-label') +
				content_tag(:div, class: 'controls') do
					image_tag form.object.send(paperclip_object).send(:url, :small)
				end
			end
		end
	end

	def status_document_link(status)
		
		if status.document && status.document.attachment?
			content_tag(:span, "Attachment", class: "label label-info") +
			link_to(status.document.attachment_file_name, status.document.attachment.url)
			
		end
	end

	def flash_class(type)
		case type
		when :alert
			"alert-danger"
		when :notice
			"alert-info"
		else
			""
		end
	end

	def avatar_profile_link(user, image_options={}, html_options={})
		avatar_url = user.avatar? ? user.avatar.url(:thumb) : user.gravatar_url
		link_to(image_tag(avatar_url, image_options), profile_path(user.profile_name), html_options)
	end

	def page_header(&block)
		content_tag(:div, capture(&block), class: 'page-header')
	end
	
	def can_display_status?(status)
		signed_in? || !signed_in?
	end
end
