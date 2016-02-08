if (Object.const_defined?("SimpleForm") && Gem.loaded_specs["simple_form"].version.version[0,1] >= "2")

  class RichInput < SimpleForm::Inputs::Base  
    def input
      scope_type = object_name
      scope_id = object.id
      editor_options = Rich.options(options[:config], scope_type, scope_id)

      input_id = "#{object_name}_#{attribute_name}"
      
      #replace all non alphanumeric, underscore or periods with underscore
      input_id.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '_'  

      #convert double underscores to single
      input_id.gsub! /_+/,"_"

      #strip off leading/trailing underscore
      input_id.gsub! /\A[_\.]+|[_\.]+\z/,""

      input_id = input_id.downcase

      <<-eos
      	#{@builder.text_area(attribute_name, input_html_options)}
	       <script>
      	   CKEDITOR.replace( '#{input_id}', #{editor_options.to_json.html_safe} );
         </script>
      eos

    end

  end

end

