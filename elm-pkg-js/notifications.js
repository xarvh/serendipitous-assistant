/* elm-pkg-js
port xarvh_elm_notifications_to_js : { title : String, body : String, icon : String } -> Cmd msg
*/

exports.init = (app) => {
    app.ports.xarvh_elm_notifications_to_js.subscribe((pars) => {
        Notification.requestPermission().then(() => {
            new Notification(pars.title, { body: pars.body, icon: pars.icon || null });
        });
    });
};
