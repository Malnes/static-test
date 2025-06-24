# Teams Activity Notififacitons
A simple solution to send notifications to users using graph api and application permissions

## How to
1. Create an app registration with application permission `TeamsActivity.Send.User`
1. Create and deploy a new teams app based on the `manifest.json` template. Remember to replace the values in <>
2. Publish and install the teams app for the user(s) youd like to be able to send notificaitons to
3. (OPTIONAL) Deploy the contents of `index.html` to your desired web server. If doing so, remember to update the `manifest.json` with the new domain and the new content and website url
4. Test the notifications by signing in to graph api with application permissions and run the `new-teamsActivityNotification` function
   
