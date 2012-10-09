if (Object.const_defined?("Simpleform") && Gem.loaded_specs["simple_form"].version.version[0,1] == "2")
    
    class RichPickerInput < ::SimpleForm::Inputs::StringInput

      def to_html 
        scope_type = object_name
        scope_id = object.id
        editor_options = Rich.options(options[:config], scope_type, scope_id)
        
        local_input_options = {
          :class => 'rich-picker',
          :style => editor_options[:style]
        }

        input_wrapping do

          label_html <<
          if editor_options[:hidden_input] == true
            field = builder.hidden_field(method, local_input_options.merge(input_html_options)) 
          else
            field = builder.text_field(method, local_input_options.merge(input_html_options)) 
          end

          field  <<
          " <a href='#{Rich.editor[:richBrowserUrl]}' class='button'>#{I18n.t('picker_browse')}</a>".html_safe <<
          "</br></br><img class='rich-image-preview' src='#{@object.send(method).nil? ? editor_options[:placeholder_image] : @object.send(method) }' style='height: 100px' />".html_safe <<
          "<script>alert('hello');$(function(){$('##{input_html_options[:id]}_input a').click(function(e){ e.preventDefault(); assetPicker.showFinder('##{input_html_options[:id]}', #{editor_options.to_json.html_safe})})})</script>".html_safe

        end
      end

    end
    
end
