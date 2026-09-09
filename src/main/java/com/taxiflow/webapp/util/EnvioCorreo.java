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
 *
 * @author CarlosN
 */
public class EnvioCorreo {

    /** Carga usuario y contraseña de aplicación desde el classpath (src/main/resources/mail.properties). */
    private static Properties cargarCredenciales() throws IOException {
        Properties props = new Properties();
        try (InputStream in = EnvioCorreo.class.getClassLoader()
                .getResourceAsStream("mail.properties")) {
            if (in == null) {
                throw new IOException("No se encontró mail.properties en el classpath. "
                        + "Verifica que esté en src/main/resources/mail.properties");
            }
            props.load(in);
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
        Properties credenciales = cargarCredenciales();
        final String usuarioGmail = credenciales.getProperty("mail.username");
        final String claveApp = credenciales.getProperty("mail.password");

        if (usuarioGmail == null || claveApp == null) {
            throw new IOException("mail.properties debe tener mail.username y mail.password definidos");
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
