/*
Mailkit-This is a library to install Email with .Net Core
Steps
1) Install the NuGet package "Mailkit"
2) Create a Services folder and a Email sub folder in your project
3) Create a Folder structure as shown below and add in the files below

Services
|->Email
	|->BaseFiles
		|->BaseModels
			(EmailAddress.cs, EmailMessage.cs,EmailConfiguration.cs)
		|->BaseInterfaces
			(IEmailConfiguration.cs,IEmailService.cs)
		|->BaseService
			(EmailService.cs)
	|->Models
		(Add Interfacing Models to send Emails)
	|->EmailInterfaces
		(Add Email Interfaces Here)
	|->EmailServices
		(Add Email Methods here like EmailService Extensions)

4) Use the Send and ReceiveEmail methods to implement your own email services.
5) Once added, implement your Email Services, the example shown is EmailExtensions
*/


//Setup an Email Address POCO

public class EmailAddress
{
	public string LastName { get; set; }
	public string FirstName { get; set; }
	public string UserId { get; set; }
	public string Address { get; set; }
}

//Setup an Email Message Class POCO

public class EmailMessage
{
	public EmailMessage()
	{
		ToAddresses = new List<EmailAddress>();
		FromAddresses = new List<EmailAddress>();
	}

	public List<EmailAddress> ToAddresses { get; set; }
	public List<EmailAddress> FromAddresses { get; set; }
	public string Subject { get; set; }
	public string Content { get; set; }
	public string CC { get; set; }
	public string BCC { get; set; }
	public string headers { get; set; }
} 


//Setup a public interface for Email Configuration

public interface IEmailConfiguration
{
	string SmtpServer { get; }
	int SmtpPort { get; }
	string SmtpUsername { get; set; }
	string SmtpPassword { get; set; }

	string PopServer { get; }
	int PopPort { get; }
	string PopUsername { get; }
	string PopPassword { get; }
}

//Setup a POCO for Email Configuration

public class EmailConfiguration : IEmailConfiguration
{
	public string SmtpServer { get; set; }
	public int SmtpPort  { get; set; }
	public string SmtpUsername { get; set; }
	public string SmtpPassword { get; set; }

	public string PopServer { get; set; }
	public int PopPort { get; set; }
	public string PopUsername { get; set; }
	public string PopPassword { get; set; }
}

//Add this email configuration to appsettings.json

"EmailConfiguration": {
    "SmtpServer": "smtp.myserver.com",
    "SmtpPort": 465,
    "SmtpUsername": "smtpusername",
    "SmtpPassword": "smtppassword",

    "PopServer": "popserver",
    "PopPort": 995,
    "PopUsername": "popusername", 
    "PopPassword" :  "poppassword"
  }

//Add the following to configure services

services.AddMvc();
services.AddSingleton<IEmailConfiguration>(Configuration.GetSection("EmailConfiguration").Get<EmailConfiguration>());
services.AddTransient<IEmailService, EmailService>();
//This is the name of your final Email methods.
services.AddTransient<IEmailExtensions, EmailExtensions>();


//Add a public interface IEmailService
public interface IEmailService
{
	void Send(EmailMessage emailMessage);
	List<EmailMessage> ReceiveEmail(int maxCount = 10);
}

//Implement the interface below
public class EmailService : IEmailService
{
	private readonly IEmailConfiguration _emailConfiguration;

	public EmailService(IEmailConfiguration emailConfiguration)
	{
		_emailConfiguration = emailConfiguration;
	}

	public List<EmailMessage> ReceiveEmail(int maxCount = 10)
	{
		using (var emailClient = new Pop3Client())
		{
			emailClient.Connect(_emailConfiguration.PopServer, _emailConfiguration.PopPort, true);

			emailClient.AuthenticationMechanisms.Remove("XOAUTH2");

			emailClient.Authenticate(_emailConfiguration.PopUsername, _emailConfiguration.PopPassword);

			List<EmailMessage> emails = new List<EmailMessage>();
			for(int i=0; i < emailClient.Count && i < maxCount; i++)
			{
				var message = emailClient.GetMessage(i);
				var emailMessage = new EmailMessage
				{
					Content = !string.IsNullOrEmpty(message.HtmlBody) ? message.HtmlBody : message.TextBody,
					Subject = message.Subject
				};
				emailMessage.ToAddresses.AddRange(message.To.Select(x => (MailboxAddress)x).Select(x => new EmailAddress { Address = x.Address, Name = x.Name }));
				emailMessage.FromAddresses.AddRange(message.From.Select(x => (MailboxAddress)x).Select(x => new EmailAddress { Address = x.Address, Name = x.Name }));
							emails.Add(emailMessage);
			}

			return emails;
		}
	}

	public void Send(EmailMessage emailMessage)
	{
		var message = new MimeMessage();
		message.To.AddRange(emailMessage.ToAddresses.Select(x => new MailboxAddress(x.Name, x.Address)));
		message.From.AddRange(emailMessage.FromAddresses.Select(x => new MailboxAddress(x.Name, x.Address)));

		message.Subject = emailMessage.Subject;
		//We will say we are sending HTML. But there are options for plaintext etc. 
		message.Body = new TextPart(TextFormat.Html)
		{
			Text = emailMessage.Content
		};

		//Be careful that the SmtpClient class is the one from Mailkit not the framework!
		using (var emailClient = new SmtpClient())
		{
			//The last parameter here is to use SSL (Which you should!)
			emailClient.Connect(_emailConfiguration.SmtpServer, _emailConfiguration.SmtpPort, true);

			//Remove any OAuth functionality as we won't be using it. 
			emailClient.AuthenticationMechanisms.Remove("XOAUTH2");

			emailClient.Authenticate(_emailConfiguration.SmtpUsername, _emailConfiguration.SmtpPassword);

			emailClient.Send(message);

			emailClient.Disconnect(true);
		}
	}
}


