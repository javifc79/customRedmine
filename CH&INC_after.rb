require './const.rb'

def include_attachment(file)
  attachment_file = Rack::Multipart::UploadedFile.new(file['path'], file['contentType'], binary = false)
  Attachment.create(
      :container => self,
      :file => attachment_file,
      :description => file['desc'].to_s,
      :author => User.current
  )
end
def create_subtask(arr_st)
  arr_st.each { |x|
    Issue.create!(
        :author => User.current,
        :project => Project.find_by_identifier('proc-camb'),
        :tracker_id => Trck::SRV_ACTIVIDADCH,
        :priority_id => IssuePriority.find_by_name('N/A'),
        :assigned_to_id => x.grupo,
        :parent_issue_id => self.id,
        :due_date => @fechafin,
        :start_date => @fechainicio,
        :subject => x.subject,
        :is_private => x.privada,
        :description => x.descripcion)

  }
end



if @need_create
  if self.is_private
    privada = '1'
  else
    privada = '0'
  end
  tarea = Struct.new(:subject, :descripcion, :grupo, :privada)
  adjunto = 'no'
  arr_subtask = Array.new
  case self.custom_field_value(Csf::JOB_PLAN)
    when 'SC-CHG-MAYOR'
      arr_subtask[0] = tarea.new('Tarea de implementación 1', 'Tarea de implementación 1', self.assigned_to_id, privada)
      arr_subtask[1] = tarea.new('Tarea de implementación 2', 'Actualizacion de la CMDB con las modificaciones derivadas del cambio', Grp::IBM_ES_GESCONF, privada)

    when 'SC-CHG-MAYOR-BRS-TEST'
      arr_subtask[0] = tarea.new('Tarea de implementación 1', 'Tarea de Implementacion 1 del cambio BRS Simulacro', self.assigned_to_id, privada)

    when 'SC-CHG-MAYOR-EOS'
      arr_subtask[0] = tarea.new('Creacción de checklist internas de EOS', 'Solicitud de inicio del flujo de verificaciones. Una petición por cada activo', self.assigned_to_id, privada)
      arr_subtask[1] = tarea.new('Añadir aprobación del cliente y aceptación de riesgos', 'Revisión de CheckList internas IBM y activación del servicio', Grp::IBM_ES_SM, privada)
      arr_subtask[2] = tarea.new('Actualización de CMDB', 'Actualizacion de la CMDB con las modificaciones derivadas del cambio', Grp::IBM_ES_GESCONF, privada)

    when 'SC-CHG-MAYOR-UOS'
      arr_subtask[0] = tarea.new('Creacción de checklist internas de UOS', 'Solicitud de inicio del flujo de verificaciones. Una petición por cada activo', self.assigned_to_id, privada)
      arr_subtask[1] = tarea.new('Revisión de resultado de CheckList', 'Revisión de CheckList internas IBM y Desactivación del Servicio', Grp::IBM_ES_SM, privada)
      arr_subtask[2] = tarea.new('Actualizacion de CMDB', 'Actualizacion de la CMDB con las modificaciones derivadas del cambio', Grp::IBM_ES_GESCONF, privada)

    when 'SC-CHG-MEDIO'
      arr_subtask[0] = tarea.new('Tarea de implementación 1', 'Tarea de implementación 1 del cambio medio', self.assigned_to_id, privada)

    when 'SC-CHG-MEDIO-BRS-TEST'
      arr_subtask[0] = tarea.new('Tarea de implementación 1', 'Tarea de Implementación 1 del cambio medio BRS simulacro', self.assigned_to_id, privada)

    when 'SC-CHG-MEDIO-SEGURIDAD-FW'
      arr_subtask[0] = tarea.new('Tarea de implementación 1 - Seguridad FW', 'Tarea de implementación 1 del cambio medio', self.assigned_to_id, privada)

    when 'SC-CHG-MEDIO-CHANGE-IP'
      arr_subtask[0] = tarea.new('Tarea de implementación 1 - CHIPs', 'Cambiar IP o Hostname', self.assigned_to_id, privada)
      arr_subtask[1] = tarea.new('Tarea de implementación 2 - Check HMC', 'Verificar el cambio de IP o Hostname en HMC o equivalente.', self.assigned_to_id, privada)
      arr_subtask[2] = tarea.new('Tarea de implementación 3 - Check Backup', 'Verificar el cambio de IP o Hostname en sistemas de copias de seguridad', Grp::IBM_ES_SCBACKUP, privada)
      arr_subtask[3] = tarea.new('Tarea de implementación 4 - Check PMP', 'Verificar el cambio de IP o Hostname en caja de password', Grp::IBM_ES_SEG, privada)
      arr_subtask[4] = tarea.new('Tarea de implementacion 5 - Check SECAudit', 'Verificar el cambio de IP o Hostname en herramienta de auditoría de seguridad', Grp::IBM_ES_SEG, privada)
      arr_subtask[5] = tarea.new('Tarea de implementación 6 - Check Monitorización', 'Verificar el cambio de IP o Hostname en la herramienta de monitorización. Nagios, Tívoli o similar', Grp::IBM_ES_SCMONIT, privada)
      arr_subtask[6] = tarea.new('Tarea de implementación 7 - Documentación', 'Actualizar documentación.', self.assigned_to_id, privada)
      arr_subtask[7] = tarea.new('Tarea de implementación 8 - Diagramas', 'Actualizar diagramas de red', Grp::IBM_ES_SCNET, privada)
      arr_subtask[8] = tarea.new('Tarea de implementación 9 - Actualización CMDB', 'Actualización de la CMDB con las modificaciones derivadas del cambio', Grp::IBM_ES_GESCONF, privada)

    when 'SC-CHG-INSTALL-RED'
      arr_subtask[0] = tarea.new('Tarea de implementación 1 - Instalación y Configuración', 'Instalación del equipo y configuración básica', self.assigned_to_id, privada)
      arr_subtask[1] = tarea.new('Tarea de implementación 2 - Documentación', 'Actualizar documentación y diagramas de red ', Grp::IBM_ES_SCNET, privada)
      arr_subtask[2] = tarea.new('Tarea de implementación 3 - Documentación', 'Actualizar documentación de direccionamiento de red ', Grp::IBM_ES_SCNET, privada)
      arr_subtask[3] = tarea.new('Tarea de implementación 4 - CMDB', 'Actualizar IP de gestión en inventario', Grp::IBM_ES_GESCONF, privada)
      arr_subtask[4] = tarea.new('Tarea de implementación 5 - EOS', 'Solicitar EOS', Grp::IBM_ES_SM, privada)

    when 'SC-CHG-MEDIO-NETWORKING'
      arr_subtask[0] = tarea.new('Tarea de implementación 1 - Instalación y Configuración', 'Instalación del equipo y configuración básica', self.assigned_to_id, privada)
      arr_subtask[1] = tarea.new('Tarea de implementación 2 - Documentación', 'Actualizar documentación y diagramas de red ', Grp::IBM_ES_SCNET, privada)
      arr_subtask[2] = tarea.new('Tarea de implementación 3 - Documentación', 'Actualizar documentación de direccionamiento de red ', Grp::IBM_ES_SCNET, privada)

    when 'SC-CHG-MENOR'
      arr_subtask[0] = tarea.new('Tarea de implementación 1', 'Tarea de implementación 1', self.assigned_to_id, privada)

    when 'SC-CHG-MENOR-SEGURIDAD-PRIV'
      arr_subtask[0] = tarea.new('Tarea de implemantación 1 -  Registro, disclaimer y solicitud retirada', 'Registrar la cesión, elevar riesgo y solicitar la retirada de privilegios con fecha según la caducidad solicitada', Grp::IBM_ES_SEG, privada)
      arr_subtask[1] = tarea.new('Tarea de implementación 2  - Cesión de privilegios según plantilla', 'Realizar la cesión de privilegios según lo aprobado y recogido en la plantilla adjunta', self.assigned_to_id, privada)

    when 'SC-CHG-MENOR-SEGURIDAD-RETPRIV'
      arr_subtask[0] = tarea.new('Tarea de implementación 1 - Actualización registro cesiones', 'Actualización registro cesiones', Grp::IBM_ES_SEG, privada)
      arr_subtask[1] = tarea.new('Tarea de implementación 2 - Retirada de privilegios', 'Retirada de privilegios según plantilla', self.assigned_to_id, privada)

    when 'SC-CHG-MENOR-PARCHE'
      arr_subtask[0] = tarea.new('Tarea de implementación 1  - Gestión de parches', 'Tarea de Implementación 1 de Gestión y aplicación de parches', self.assigned_to_id, privada)

    when 'SC-CHG-URGENTE-IN-CRI'
      arr_subtask[0] = tarea.new('Tarea de implementación 1  - incidencia crítica', 'Tarea de Implementación 1 del cambio urgente por incidencia crítica', self.assigned_to_id, privada)

    when 'SC-CHG-URGENTE-IN-GRA'
      arr_subtask[0] = tarea.new('Tarea de implementación 1  - Incidencia grave', 'Tarea de Implementación 1 del cambio urgente por incidencia grave', self.assigned_to_id, privada)

    when 'SC-CHG-URGENTE-IN-LEVE'
      arr_subtask[0] = tarea.new('Tarea de implementación 1  - Incidencia leve', 'Tarea de Implementación 1 del cambio urgente por incidencia leve', self.assigned_to_id, privada)

    when 'SC-CHG-URG-DATACENTER'
      arr_subtask[0] = tarea.new('Tarea de implementación 1  - Disaster Datacenter', 'Tarea de Implementación 1 del cambio urgente por Disaster Data Center', self.assigned_to_id, privada)

    when 'SC-PSE-INFO'
      arr_subtask[0] = tarea.new('Tarea de implementación 1  - Solicitud de información', 'Tarea de Implementación 1 del la solicitud de información', self.assigned_to_id, privada)

    when 'SC-PSE-GEST-USUARIO'
      arr_subtask[0] = tarea.new('Tarea de implementación 1  - Gestión de usuario', 'Tarea de Implementación de alta, baja o modificación de usuario', self.assigned_to_id, privada)
      arr_subtask[1] = tarea.new('Tarea de implementación 2  - Registro de seguridad', 'Validación o registro por parte de Seguridad del cambio de un usuario compartido', Grp::IBM_ES_SEG, privada)
      adjunto = 'SC-PSE-GEST-USUARIO'
    when 'SC-PSE-RESETPW'
      arr_subtask[0] = tarea.new('Tarea de implementación 1  - Password Reset', 'Tarea de Implementación 1 de reseteo de password de cuenta de usuario', self.assigned_to_id, privada)

    when 'SC-PSE-OTROS'
      arr_subtask[0] = tarea.new('Tarea de implementación 1  - Peticion de servicio', 'Tarea de Implementación 1 de Petición de Servicio Otros', self.assigned_to_id, privada)

    when 'SC-PSE-OTROS-GESTVUL'
      arr_subtask[0] = tarea.new('Tarea de implementación 1  - Gestión de vulnerabilidades dentro del servicio', 'Tarea de Implementación 1 de Gestión de vulnerabilidades dentro del servicio', Grp::IBM_ES_SEG, privada)

    when 'SC-PSE-OTROS-SERVPROF'
      arr_subtask[0] = tarea.new('Tarea de implementación 1  - evidencia del acuerdo alcanzado con IBM y el cliente', 'Inclusión de evidencia del acuerdo alcanzado con IBM y el cliente', self.assigned_to_id, privada)
      arr_subtask[1] = tarea.new('Tarea de implementación 2  - Ejecución Técnica', 'Tarea de Implementación Ejecución Técnica', self.assigned_to_id, privada)

    when 'SC-PSE-PROBLEMAS'
      arr_subtask[0] = tarea.new('Tarea de implementación 1  - Análisis de Problema', 'Tarea de implementación 1 de Análisis de Problema', self.assigned_to_id, privada)

    when 'SC-PSE-BACKUP-REQUEST'
      arr_subtask[0] = tarea.new('Tarea de implementación 1  - Backup', 'Tarea de implementación 1 de Solicitud de Backup', self.assigned_to_id, privada)

    when 'SC-PSE-BACKUP-RESTORE'
      arr_subtask[0] = tarea.new('Tarea de implementación 1  - Restore Backup', 'Tarea de implementación 1 de Solicitud de Restore Backup', self.assigned_to_id, privada)

    when 'SC-PSE-BACKUP-RESTORECHECK'
      arr_subtask[0] = tarea.new('Tarea de implementación 1  - Restore Check Backup', 'Tarea de implementación 1 de Solicitud de Verificación de Restore de Backup', self.assigned_to_id, privada)

    when 'SC-PSE-CONS-NEW'
      arr_subtask[0] = tarea.new('Tarea de implementación 1 - Etiquetado y cableado', 'Zona xxx. Etiquetar y cablear el POE', self.assigned_to_id, privada)
      arr_subtask[1] = tarea.new('Tarea de implementación 2 - Instalación Imagen', 'Zona xxx. Instalar la imagen homologada en el POE', self.assigned_to_id, privada)
      arr_subtask[2] = tarea.new('Tarea de implementación 3 - Instalación Antivirus', 'Instalar el antivirus', self.assigned_to_id, privada)
      arr_subtask[3] = tarea.new('Tarea de implementación 4 - Check Consola AV', 'Verificar alta en consola de antivirus', Grp::IBM_ES_SEG, privada)
      arr_subtask[4] = tarea.new('Tarea de implementación 5 - Config. Monitorización', 'Configurar monitorización', Grp::IBM_ES_SCMONIT, privada)
      arr_subtask[5] = tarea.new('Tarea de implementación 6 - CMDB', 'Actualizar CMDB', Grp::IBM_ES_GESCONF, privada)

    when 'SC-PSE-CONS-BAJA'
      arr_subtask[0] = tarea.new('Tarea de implementación 1 - Baja AV', 'Cursar la baja en la consola de antivirus', Grp::IBM_ES_SEG, privada)
      arr_subtask[1] = tarea.new('Tarea de implementación 2 - Monitorización', 'Cursar baja del POE en sistema de monitorización', Grp::IBM_ES_SCMONIT, privada)
      arr_subtask[2] = tarea.new('Tarea de implementación 3 - CMDB', 'Modificar los campos de estado (baja/repuesto) según venga indicado en el Excel adjunto a la petición', Grp::IBM_ES_GESCONF, privada)
      arr_subtask[3] = tarea.new('Tarea de implementación 4 - Imagen', 'Zona xxx. Revisar si es la última imagen del entorno para proceder a borrarla del repositorio',self.assigned_to_id, privada)
      arr_subtask[4] = tarea.new('Tarea de implementación 5 - Formateo', 'Zona xxx. Formatear la máquina', self.assigned_to_id, privada)

    when 'SC-PSE-CONS-SUSTITUCION'
      arr_subtask[0] = tarea.new('Tarea de implementación 1 - Etiquetado y cableado', 'Zona xxx. Etiquetar y cablear el POE', self.assigned_to_id, privada)
      arr_subtask[1] = tarea.new('Tarea de implementación 2 - Instalación Imagen', 'Zona xxx. Instalar la imagen homologada en el POE', self.assigned_to_id, privada)
      arr_subtask[2] = tarea.new('Tarea de implementación 3 - Instalación Antivirus', 'Instalar el antivirus', Grp::IBM_ES_SEG, privada)
      arr_subtask[3] = tarea.new('Tarea de implementación 4 - Alta Monitorización', 'Verificar alta en consola de antivirus', Grp::IBM_ES_SCMONIT, privada)
      arr_subtask[4] = tarea.new('Tarea de implementación 5 - CMDB', 'Modificar en inventario los campos estado a explotación y tipo de servicio', Grp::IBM_ES_GESCONF, privada)
      arr_subtask[5] = tarea.new('Tarea de implementación 6 - Baja AV', 'Cursar la baja en la consola de antivirus', Grp::IBM_ES_SEG, privada)
      arr_subtask[6] = tarea.new('Tarea de implementación 7 - Baja Monitorización', 'Tramitar la baja en el sistema de monitorización', Grp::IBM_ES_SCMONIT, privada)
      arr_subtask[7] = tarea.new('Tarea de implementación 8 - CMDB', 'Modificar los campos de estado -baja/repuesto- según venga indicado en el Excel adjunto a la petición', Grp::IBM_ES_GESCONF, privada)
      arr_subtask[8] = tarea.new('Tarea de implementación 9 - Imagen Repositorio', 'Zona xxx. Revisar si es la última imagen del entorno para proceder a borrarla del repositorio', self.assigned_to_id, privada)
      arr_subtask[9] = tarea.new('Tarea de implementación 10 - Formateo', 'Zona xxx. Formatear la máquina', self.assigned_to_id, privada)
      arr_subtask[10] = tarea.new('Tarea de implementación 11 - Retirada', 'Zona xxx. Retirar el equipo antiguo de su ubicación actual', self.assigned_to_id, privada)

    when 'SC-PSE-CONS-MOVIMIENTO'
      arr_subtask[0] = tarea.new('Tarea de implementación 1 - CHIP', 'Cambiar IP del POE', self.assigned_to_id, privada)
      arr_subtask[1] = tarea.new('Tarea de implementación 2 - Check AV', 'Check Antivirus', Grp::IBM_ES_SEG, privada)
      arr_subtask[2] = tarea.new('Tarea de implementación 3 - UPGDNS', 'UPGDNS', self.assigned_to_id, privada)
      arr_subtask[3] = tarea.new('Tarea de implementación 4 - Monitorización', 'Configuración de la monitorización', Grp::IBM_ES_SCMONIT, privada)
      arr_subtask[4] = tarea.new('Tarea de implementación 5 - CMDB', 'Actualización de CMDB', Grp::IBM_ES_GESCONF, privada)

    when 'SC-PSE-CONS-REPUESTO'
      arr_subtask[0] = tarea.new('Tarea de implementación 1 - Etiquetado y cableado', 'Zona xxx. Etiquetar y cablear el POE', self.assigned_to_id, privada)
      arr_subtask[1] = tarea.new('Tarea de implementación 2 - Instalación Imagen', 'Zona xxx. Instalar la imagen homologada en el POE	', self.assigned_to_id, privada)
      arr_subtask[2] = tarea.new('Tarea de implementación 3 - Instalación Antivirus', 'Instalar el antivirus', Grp::IBM_ES_SCWIN, privada)
      arr_subtask[3] = tarea.new('Tarea de implementación 4 - Check Consola AV', 'Verificar alta en consola de antivirus', Grp::IBM_ES_SEG, privada)
      arr_subtask[4] = tarea.new('Tarea de implementación 5 - Config. Monitorización', 'Configurar monitorización', Grp::IBM_ES_SCMONIT, privada)
      arr_subtask[5] = tarea.new('Tarea de implementación 6 - CMDB', 'Modificar en inventario los campos de estado a Repuesto y tipo de servicio No gestionada', Grp::IBM_ES_GESCONF, privada)

    when 'SC-PSE-CONS-HOMOLOGACION'
      arr_subtask[0] = tarea.new('Tarea de implementación 1 - Generar Imagen', 'Generación de la Imagen', self.assigned_to_id, privada)
      arr_subtask[1] = tarea.new('Tarea de implementación 2 - Revisión de Imagen', 'Revisión de la homologación, incluir en el documento de homologación de POEs', Grp::IBM_ES_SCWIN, privada)
      arr_subtask[2] = tarea.new('Tarea de implementación 3 - Generación ticket EOS de Consolas', 'Generación ticket EOS de Consolas', Grp::IBM_ES_SM, privada)
      arr_subtask[3] = tarea.new('Tarea de implementación 4 - Aprobación Soporte funcional', 'Comprobación por parte de soporte funcional, que el aplicativo funciona correctamente', Grp::IBM_ES_SM, privada)

    when 'SC-PSE-SEGURIDAD-ACCESO'
      arr_subtask[0] = tarea.new('Tarea de implementación 1 - Apertura de Firewall', 'Apertura de Firewall para acceso a redes de sistemas de control', self.assigned_to_id, privada)

    when 'SC-PSE-CMDB-MOD'
      arr_subtask[0] = tarea.new('Tarea de implementación 1 - CMDB', 'Modificación de inventario según plantilla adjunta.', Grp::IBM_ES_GESCONF, privada)
    else
      errors.add 'Job-Plan actualmente no implantado.', ''

  end
  create_subtask(arr_subtask)
  case adjunto
    when 'SC-PSE-GEST-USUARIO'
      include_attachment(Att::SC_PSE_GEST_USUARIO)

  end



end
