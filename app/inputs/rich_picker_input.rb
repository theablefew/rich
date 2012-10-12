if (Object.const_defined?("SimpleForm") && Gem.loaded_specs["simple_form"].version.version[0,1] == "2")
 class RichPickerInput < SimpleForm::Inputs::Base
  def input 
   scope_type = object_name
   scope_id = object.id
   editor_options = Rich.options(options[:config], scope_type, scope_id)
        
   local_input_options = {
    :class => 'rich-picker',
    :style => editor_options[:style]
   }

   <<-eos
    <a href='#{Rich.editor[:richBrowserUrl]}' class='button'>#{I18n.t('picker_browse')}</a>
    </br></br>
    <img class='rich-image-preview' src='#{@object.send(method).nil? ? editor_options[:placeholder_image] : @object.send(method) }' style='height: 100px' />
    <script>
     $(function(){
      $('##{input_html_options[:id]}_input a').click(function(e){ 
       e.preventDefault(); 
       assetPicker.showFinder('##{input_html_options[:id]}', #{editor_options.to_json.html_safe})
      })
     })
    </script>
   eos
  end
 end
end
