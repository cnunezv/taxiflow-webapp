package com.taxiflow.webapp.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 * Utilidad para el envío de correos de recuperación de clave vía Gmail SMTP.
 * Lee las credenciales desde mail.properties (fuera del control de versiones,
 * ver .gitignore) para no exponer la contraseña de aplicación en el repo público.
 * Los correo se envian son exito
 * @author CarlosN
 */
public class EnvioCorreo {

    /**
     * Devuelve el valor de una variable de entorno, o null si no está definida.
     * En Render las credenciales se configuran como variables de entorno
     * (MAIL_USERNAME y MAIL_PASSWORD), nunca dentro del repositorio.
     */
    private static String env(String clave) {
        String valor = System.getenv(clave);
        return (valor == null || valor.trim().isEmpty()) ? null : valor;
    }

    /**
     * Carga usuario y contraseña de aplicación desde el classpath
     * (src/main/resources/mail.properties). Solo se usa en desarrollo local:
     * ese archivo está en .gitignore y no viaja al repositorio.
     * Devuelve un Properties vacío si el archivo no existe.
     */
    private static Properties cargarCredenciales() throws IOException {
        Properties props = new Properties();
        try (InputStream in = EnvioCorreo.class.getClassLoader()
                .getResourceAsStream("mail.properties")) {
            if (in != null) {
                props.load(in);
            }
        }
        return props;
    }

    /**
     * Envía un correo de texto plano usando la cuenta configurada en mail.properties.
     * @param destinatario email de quien recibirá el correo
     * @param asunto asunto del mensaje
     * @param cuerpo contenido del mensaje
     */
    public static void enviarCorreo(String destinatario, String asunto, String cuerpo) throws Exception {
        // 1) Primero variables de entorno (producción en Render).
        // 2) Si no existen, mail.properties del classpath (desarrollo local).
        Properties credenciales = cargarCredenciales();
        final String usuarioGmail = env("MAIL_USERNAME") != null
                ? env("MAIL_USERNAME") : credenciales.getProperty("mail.username");
        final String claveApp = env("MAIL_PASSWORD") != null
                ? env("MAIL_PASSWORD") : credenciales.getProperty("mail.password");

        if (usuarioGmail == null || claveApp == null) {
            throw new IOException("Faltan credenciales de correo. Define las variables de entorno "
                    + "MAIL_USERNAME y MAIL_PASSWORD, o crea src/main/resources/mail.properties "
                    + "con mail.username y mail.password.");
        }

        // Configuración del servidor SMTP de Gmail con TLS
        Properties propsSmtp = new Properties();
        propsSmtp.put("mail.smtp.auth", "true");
        propsSmtp.put("mail.smtp.starttls.enable", "true");
        propsSmtp.put("mail.smtp.host", "smtp.gmail.com");
        propsSmtp.put("mail.smtp.port", "587");

        Session session = Session.getInstance(propsSmtp, new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(usuarioGmail, claveApp);
            }
        });

        Message mensaje = new MimeMessage(session);
        mensaje.setFrom(new InternetAddress(usuarioGmail));
        mensaje.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
        mensaje.setSubject(asunto);
        mensaje.setText(cuerpo);

        Transport.send(mensaje);
    }
}
