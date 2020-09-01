class MyFormBuilder < ActionView::Helpers::FormBuilder

  def text_section(method, title, options = {})
    @template.content_tag(:div,
      @template.content_tag(:div, title, { class: 'text-gray-900 border-b border-gray-700 text-2xl', style: "width: fit-content; width: -moz-fit-content;" }) +
        @template.text_field(@object_name, method, objectify_options(options.merge(class: 'border bg-white shadow-md rounded p-2 mt-2 w-full'))), { class: '' })
  end

  def password_section(method, title, options = {})
    @template.content_tag(:div,
      @template.content_tag(:div, title, { class: 'text-gray-900 border-b border-gray-700 text-2xl', style: "width: fit-content; width: -moz-fit-content;" }) +
        @template.password_field(@object_name, method, objectify_options(options.merge(class: 'border bg-white shadow-md rounded p-2 mt-2 w-full'))), { class: '' })
  end
end
