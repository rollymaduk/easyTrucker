@STATE_MATCHED='matched'
@STATE_UNMATCHED='unmatched'
@STATE_NEW='new'
@STATE_BOOKED='accepted'
@STATE_ASSIGNED='booked'
@STATE_CANCELLED='cancelled'
@STATE_SUCCESS='delivered'
@STATE_LATE='late'
@STATE_ISSUE='issue'
@STATE_DISPATCH='dispatched'
@STATE_BIDDED='bidded'
@STATE_CLOSED='closed'
@STATE_EXPIRE='expired'

@ALL_ACTIVE_STATES=[STATE_NEW, STATE_BOOKED, STATE_DISPATCH, STATE_CANCELLED, STATE_LATE, STATE_ISSUE, STATE_SUCCESS,
             STATE_ASSIGNED,STATE_CLOSED,STATE_EXPIRE]

@NON_CANCEL_STATES=[STATE_DISPATCH, STATE_CANCELLED, STATE_LATE, STATE_ISSUE, STATE_SUCCESS,STATE_CLOSED,STATE_EXPIRE]

@ROLE_DRIVER='driver'
@ROLE_SHIPPER='shipper'
@ROLE_TRUCKER='trucker'
@ROLE_CLERK='clerk'

@COLLECTION_BID='Bids'
@COLLECTION_REQUEST='Schedules'
@COLLECTION_USER='Meteor.users'
@COLLECTION_COMMENT='Rp_Comments'

@TEMPLATE_REMINDER="Reminders"


@ERROR_BID_QUOTE="Quoted price must be less or equal to max bid price"
@ERROR_PASSWORD_MISMATCH="Passwords do not match"
@ERROR_USER_EXISTS="Username or email already exists"

@TITLE_ACCURACY='accuracy'
@TITLE_TIMELINESS='timeliness'
@TITLE_PERFORMANCE='performance'
@TITLE_DELIVERY='delivery'
@TEXT_ACCURACY='provided consistent and accurate information for this transaction'
@TEXT_TIMELINESS='was on time at pickup and delivery'
@TEXT_DELIVERY='delivered goods safely with little or no issues/conflicts'
@TEXT_PERFORMANCE='satisfied and or exceeded expectations of contract terms'
@TEXT_NONE='None'

@TITLE_UPDATE='UPDATE'
@TITLE_NEW='NEW'
@TITLE_REQUEST='REQUEST'
@TITLE_BID='BID'


###@SUBSCRIBE_PREMIUM="premium_plan"
@SUBSCRIBE_STANDARD="standard_plan"
@SUBSCRIBE_PAYG="pay_as_you_go"

@TEXT_SUBSCRIBE_PREMIUM="Premium-$470.40/Transaction"
@TEXT_SUBSCRIBE_STANDARD="Standard-$49.00/Transaction"
@TEXT_SUBSCRIBE_PAYG="Pay As You Go-$10/Transaction"

@AMOUNT_PREMIUM=47000
@AMOUNT_STANDARD=4900
@AMOUNT_PAYG=1000###

@ACCOUNT_INDIVIDUAL="Individual"
@ACCOUNT_GROUP="Organization"

@COUNT_SUBS_ID="counterSubscriptionId"

@SOUNDS=["cabin_hum","welcome","arrived","its_here"
,"inspinia","spritely","zingy_blip","new_alert","uh_oh"
,"pixel","new_mail","you_got_mail","chimming"
,"whispy_chimes","fairy_bells","willows_call","clip_it"]