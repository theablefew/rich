if (Object.const_defined?("SimpleForm") && Gem.loaded_specs["simple_form"].version.version[0,1] == "2")

  class RichInput < SimpleForm::Inputs::Base  
    def input

      scope_type = object_name
      scope_id = object.id
      editor_options = Rich.options(options[:config], scope_type, scope_id)
      "#{@builder.text_area(attribute_name, input_html_options)}<script>alert('hello'); CKEDITOR.replace('#{object.class.to_s.downcase}_#{attribute_name}', #{editor_options.to_json.html_safe});</script>".html_safe  
    end
  end

end

