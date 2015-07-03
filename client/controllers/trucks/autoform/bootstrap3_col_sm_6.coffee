Template.afFormGroup_bootstrap3_col_sm_6.helpers
  skipLabel:`function bsFormGroupSkipLabel() {
  var self = this;

  var type = AutoForm.getInputType(self.afFieldInputAtts);
  return (self.skipLabel || type === "boolean-checkbox");
  }`
  ,bsFieldLabelAtts: `function bsFieldLabelAtts() {
  var atts = _.clone(this.afFieldLabelAtts);
  // Add bootstrap class
  atts = AutoForm.Utility.addClass(atts, "control-label");
  return atts;
  }`

Template.afFormGroup_bootstrap3_col_sm_3.helpers
  skipLabel:`function bsFormGroupSkipLabel() {
      var self = this;

      var type = AutoForm.getInputType(self.afFieldInputAtts);
      return (self.skipLabel || type === "boolean-checkbox");
  }`
  ,bsFieldLabelAtts: `function bsFieldLabelAtts() {
    var atts = _.clone(this.afFieldLabelAtts);
    // Add bootstrap class
    atts = AutoForm.Utility.addClass(atts, "control-label");
    return atts;
}`