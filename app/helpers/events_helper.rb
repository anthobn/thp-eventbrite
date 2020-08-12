module EventsHelper
  def basic_grid(event)
    "<div class='col-md-4 p-2'>
            <h2>#{event.title}</h2>
            <p>#{event.description}</p>
            <p><a class='btn btn-secondary' href='#{event_path(event.id)}' role='button'>Consulter l\'évènement &raquo;</a></p>
    </div>".html_safe
  end
end
