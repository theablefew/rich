if (Object.const_defined?("SimpleForm") && Gem.loaded_specs["simple_form"].version.version[0,1] == "2")

  class RichInput < SimpleForm::Inputs::Base  
    def input
      scope_type = object_name
      scope_id = object.id
      editor_options = Rich.options(options[:config], scope_type, scope_id)

      <<-eos
      	#{@builder.text_area(attribute_name, input_html_options)}
	<script>
      	 CKEDITOR.replace(
	  '#{object_name}_#{attribute_name}', 
           #{editor_options.to_json.html_safe}
	 );
        </script>
      eos
    end
  end

end

