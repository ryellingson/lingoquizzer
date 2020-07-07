class MyFormBuilder < ActionView::Helpers::FormBuilder

  def text_section(method, title, options = {})
    @template.content_tag(:label,
      @template.content_tag(:span, title, { class: 'text-gray-700' }) +
        @template.text_field(@object_name, method, objectify_options(options.merge(class: 'password-reset-input border bg-white shadow-md rounded px-2 pt-6 pb-5 mb-2 ml-2'))), { class: 'password-reset-label text-xl' })
  end

  def password_section(method, title, options = {})
    @template.content_tag(:label,
      @template.content_tag(:span, title, { class: 'text-gray-700' }) +
        @template.password_field(@object_name, method, objectify_options(options.merge(class: 'password-reset-input border bg-white shadow-md rounded px-2 pt-6 pb-5 mb-2 ml-2'))), { class: 'password-reset-label text-xl' })
  end

end
