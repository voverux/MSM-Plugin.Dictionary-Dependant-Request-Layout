<%@ WebHandler Language="C#" Class="DictionaryDependantRequestLayoutHandler" %>

using System.IO;
using System.Xml;
using System.Net;
using System.Web;
using MarvalSoftware.UI.WebUI.ServiceDesk.RFP.Plugins;
using Newtonsoft.Json;


/// <summary>
/// Dictionary Dependant Request Layout Plugin Handler
/// </summary>
public class DictionaryDependantRequestLayoutHandler : PluginHandler
{
    public override bool IsReusable { get { return false; } }

    /// <summary>
    /// Main Request Handler
    /// </summary>
    public override void HandleRequest(HttpContext context)
    {
        switch (context.Request.HttpMethod)
        {
            case "GET":
                context.Response.Write(JsonConvert.SerializeObject(new PluginSettings(this.GlobalSettings["Dictionary Id"], this.GlobalSettings["Plugin Rules"])));
                break;
        }
    }

    public class PluginSettings
    {
        public string dictionary_id { get; set; }
        public PluginRules plugin_rules { get; set; }
        public PluginSettings()
        {
            dictionary_id = string.Empty;
            plugin_rules = new List<PluginRule>();
        }
        public PluginSettings(string DictID, PluginRules Rules)
        {
            dictionary_id = DictionaryID ?? string.Empty;
            plugin_rules = ParsePluginRules(Rules) ?? new List<PluginRule>();
        }
    }
	
	internal PluginRules ParsePluginRules(string PluginRulesString)
	{
		return DeserializeJSONObject<PluginRules>(PluginRulesString);
	}
	
	public class PluginRules
    {
        public List<PluginRule> rules { get; set; }
    }

	public class PluginRule
    {
        public int[] classification_ids { get; set; }
        public int layout_id { get; set; }
    }
	
	/// <summary>
	/// JsonHelper Functions
	/// </summary>
	public static class JsonHelper
	{
		public static string replaceLBs(string jsonString)
		{
			return Regex.Replace(jsonString, @"\""[^\""]*?[\n\r]+[^\""]*?\""", m => Regex.Replace(m.Value, @"[\n\r]", "\\n"));
		}
		public static string replaceWildcards(string jsonString)
		{
			return jsonString.Replace("\\n", "").Replace("\\\"", "\"");
		}
		public static string SerializeJSONObject<T>(this T JsonObjectToSerialize)
		{
			JsonSerializerSettings jsonSettings = new JsonSerializerSettings()
			{
				TypeNameHandling = TypeNameHandling.Objects
			};
			//jsonSettings.TypeNameHandling = TypeNameHandling.Objects;
			//jsonSettings.MetadataPropertyHandling = MetadataPropertyHandling.Default;
			return JsonConvert.SerializeObject(JsonObjectToSerialize);
			//return JsonConvert.SerializeObject(JsonObjectToSerialize, Newtonsoft.Json.Formatting.Indented, jsonSettings);
		}
		public static T DeserializeJSONObject<T>(this string JsonStringToDeserialize)
		{
			try{
				JsonSerializerSettings jsonSettings = new JsonSerializerSettings()
				{
					TypeNameHandling = TypeNameHandling.Objects
				};
				//jsonSettings.TypeNameHandling = TypeNameHandling.Objects;
				//jsonSettings.MetadataPropertyHandling = MetadataPropertyHandling.Default;
				JsonSerializer serializer = new JsonSerializer();
				return JsonConvert.DeserializeObject<T>(JsonStringToDeserialize);
				//return JsonConvert.DeserializeObject<T>(JsonStringToDeserialize, jsonSettings);
			}
			catch{
				return null;
			}
		}
	}
	

}