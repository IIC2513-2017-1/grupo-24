# frozen_string_literal: true

if @owner
  json.status 'El proyecto fue eliminado correctamente'
else
  json.description 'Este proyecto no es tuyo, solo el dueño puede borrarlo'
end
