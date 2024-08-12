// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Start Page`
  String get startDayTitle {
    return Intl.message(
      'Start Page',
      name: 'startDayTitle',
      desc: '',
      args: [],
    );
  }

  /// `start our step`
  String get startDayDescription {
    return Intl.message(
      'start our step',
      name: 'startDayDescription',
      desc: '',
      args: [],
    );
  }

  /// `Home Page`
  String get homePageTitle {
    return Intl.message(
      'Home Page',
      name: 'homePageTitle',
      desc: '',
      args: [],
    );
  }

  /// `sells`
  String get homeBottomSells {
    return Intl.message(
      'sells',
      name: 'homeBottomSells',
      desc: '',
      args: [],
    );
  }

  /// `sells your items`
  String get homeBottomSellsDescription {
    return Intl.message(
      'sells your items',
      name: 'homeBottomSellsDescription',
      desc: '',
      args: [],
    );
  }

  /// `bills`
  String get homeBottomBills {
    return Intl.message(
      'bills',
      name: 'homeBottomBills',
      desc: '',
      args: [],
    );
  }

  /// `order and show your bills`
  String get homeBottomBillsDescription {
    return Intl.message(
      'order and show your bills',
      name: 'homeBottomBillsDescription',
      desc: '',
      args: [],
    );
  }

  /// `End Day process`
  String get homeBottomEndDay {
    return Intl.message(
      'End Day process',
      name: 'homeBottomEndDay',
      desc: '',
      args: [],
    );
  }

  /// `enter the final amount and inventory your items`
  String get homeBottomEndDayDescription {
    return Intl.message(
      'enter the final amount and inventory your items',
      name: 'homeBottomEndDayDescription',
      desc: '',
      args: [],
    );
  }

  /// `Sales Page`
  String get salePageTitle {
    return Intl.message(
      'Sales Page',
      name: 'salePageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Online`
  String get saleBottomOnline {
    return Intl.message(
      'Online',
      name: 'saleBottomOnline',
      desc: '',
      args: [],
    );
  }

  /// `must exist the internet`
  String get saleBottomOnlineDescription {
    return Intl.message(
      'must exist the internet',
      name: 'saleBottomOnlineDescription',
      desc: '',
      args: [],
    );
  }

  /// `Offline`
  String get saleBottomOffline {
    return Intl.message(
      'Offline',
      name: 'saleBottomOffline',
      desc: '',
      args: [],
    );
  }

  /// `the first step need internet, then sell offline`
  String get saleBottomOfflineDescription {
    return Intl.message(
      'the first step need internet, then sell offline',
      name: 'saleBottomOfflineDescription',
      desc: '',
      args: [],
    );
  }

  /// `bills page`
  String get billPageTitle {
    return Intl.message(
      'bills page',
      name: 'billPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `show your bills`
  String get billBottomShowYourBills {
    return Intl.message(
      'show your bills',
      name: 'billBottomShowYourBills',
      desc: '',
      args: [],
    );
  }

  /// `show your orders`
  String get billBottomShowYourBillsDescription {
    return Intl.message(
      'show your orders',
      name: 'billBottomShowYourBillsDescription',
      desc: '',
      args: [],
    );
  }

  /// `order the bill`
  String get billBottomOrder {
    return Intl.message(
      'order the bill',
      name: 'billBottomOrder',
      desc: '',
      args: [],
    );
  }

  /// `order now`
  String get billBottomOrderFromFactoryDescription {
    return Intl.message(
      'order now',
      name: 'billBottomOrderFromFactoryDescription',
      desc: '',
      args: [],
    );
  }

  /// `order the bill from another sp`
  String get billBottomOrderFromSp {
    return Intl.message(
      'order the bill from another sp',
      name: 'billBottomOrderFromSp',
      desc: '',
      args: [],
    );
  }

  /// `order from near sp`
  String get billBottomOrderFromSpDescription {
    return Intl.message(
      'order from near sp',
      name: 'billBottomOrderFromSpDescription',
      desc: '',
      args: [],
    );
  }

  /// `another sp orders`
  String get billBottomShowAnotherSpOrder {
    return Intl.message(
      'another sp orders',
      name: 'billBottomShowAnotherSpOrder',
      desc: '',
      args: [],
    );
  }

  /// `SPs that order from you`
  String get billBottomShowAnotherSpOrderDescription {
    return Intl.message(
      'SPs that order from you',
      name: 'billBottomShowAnotherSpOrderDescription',
      desc: '',
      args: [],
    );
  }

  /// `Show Your orders Page`
  String get showYourBillsTitle {
    return Intl.message(
      'Show Your orders Page',
      name: 'showYourBillsTitle',
      desc: '',
      args: [],
    );
  }

  /// `ID`
  String get showYourBillsId {
    return Intl.message(
      'ID',
      name: 'showYourBillsId',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get showYourBillsDate {
    return Intl.message(
      'Date',
      name: 'showYourBillsDate',
      desc: '',
      args: [],
    );
  }

  /// `from factory`
  String get showYourBillsBottomFromFactory {
    return Intl.message(
      'from factory',
      name: 'showYourBillsBottomFromFactory',
      desc: '',
      args: [],
    );
  }

  /// `from SP`
  String get showYourBillsBottomFromSp {
    return Intl.message(
      'from SP',
      name: 'showYourBillsBottomFromSp',
      desc: '',
      args: [],
    );
  }

  /// `details`
  String get showYourBillsBottomDetails {
    return Intl.message(
      'details',
      name: 'showYourBillsBottomDetails',
      desc: '',
      args: [],
    );
  }

  /// `order from factory`
  String get orderFromFactoryTitle {
    return Intl.message(
      'order from factory',
      name: 'orderFromFactoryTitle',
      desc: '',
      args: [],
    );
  }

  /// `price`
  String get orderFromFactoryPrice {
    return Intl.message(
      'price',
      name: 'orderFromFactoryPrice',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get orderFromFactoryQuantity {
    return Intl.message(
      'Quantity',
      name: 'orderFromFactoryQuantity',
      desc: '',
      args: [],
    );
  }

  /// `choose SP`
  String get orderFromFactoryChooseSP {
    return Intl.message(
      'choose SP',
      name: 'orderFromFactoryChooseSP',
      desc: '',
      args: [],
    );
  }

  /// `SP Choosen`
  String get orderFromFactorySPChoosen {
    return Intl.message(
      'SP Choosen',
      name: 'orderFromFactorySPChoosen',
      desc: '',
      args: [],
    );
  }

  /// `post`
  String get post {
    return Intl.message(
      'post',
      name: 'post',
      desc: '',
      args: [],
    );
  }

  /// `order from SP`
  String get orderFromSpTitle {
    return Intl.message(
      'order from SP',
      name: 'orderFromSpTitle',
      desc: '',
      args: [],
    );
  }

  /// `Show Another Sp Order Page`
  String get showAnotherSpOrderTitle {
    return Intl.message(
      'Show Another Sp Order Page',
      name: 'showAnotherSpOrderTitle',
      desc: '',
      args: [],
    );
  }

  /// `from sp`
  String get showAnotherSpOrderFromSp {
    return Intl.message(
      'from sp',
      name: 'showAnotherSpOrderFromSp',
      desc: '',
      args: [],
    );
  }

  /// `EndDay Page`
  String get endDayTitle {
    return Intl.message(
      'EndDay Page',
      name: 'endDayTitle',
      desc: '',
      args: [],
    );
  }

  /// `address of the envelope`
  String get endDayAddress {
    return Intl.message(
      'address of the envelope',
      name: 'endDayAddress',
      desc: '',
      args: [],
    );
  }

  /// `enter the address`
  String get endDayAddressField {
    return Intl.message(
      'enter the address',
      name: 'endDayAddressField',
      desc: '',
      args: [],
    );
  }

  /// `amount inside the envelope`
  String get endDayAmount {
    return Intl.message(
      'amount inside the envelope',
      name: 'endDayAmount',
      desc: '',
      args: [],
    );
  }

  /// `enter the amount`
  String get endDayAmountField {
    return Intl.message(
      'enter the amount',
      name: 'endDayAmountField',
      desc: '',
      args: [],
    );
  }

  /// `Inventory`
  String get endDayInventory {
    return Intl.message(
      'Inventory',
      name: 'endDayInventory',
      desc: '',
      args: [],
    );
  }

  /// `Item Name`
  String get endDayItemName {
    return Intl.message(
      'Item Name',
      name: 'endDayItemName',
      desc: '',
      args: [],
    );
  }

  /// `Remaining quantity`
  String get endDayQuantity {
    return Intl.message(
      'Remaining quantity',
      name: 'endDayQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Quantity taken`
  String get endDaytaken {
    return Intl.message(
      'Quantity taken',
      name: 'endDaytaken',
      desc: '',
      args: [],
    );
  }

  /// `Quantity Sold`
  String get endDaySold {
    return Intl.message(
      'Quantity Sold',
      name: 'endDaySold',
      desc: '',
      args: [],
    );
  }

  /// `enter the Remaining quantity`
  String get endDayHintText {
    return Intl.message(
      'enter the Remaining quantity',
      name: 'endDayHintText',
      desc: '',
      args: [],
    );
  }

  /// `enter the Quantity taken`
  String get endDaytakenHintText {
    return Intl.message(
      'enter the Quantity taken',
      name: 'endDaytakenHintText',
      desc: '',
      args: [],
    );
  }

  /// `enter the Quantity Sold`
  String get endDaySoldHintText {
    return Intl.message(
      'enter the Quantity Sold',
      name: 'endDaySoldHintText',
      desc: '',
      args: [],
    );
  }

  /// `Wellcome`
  String get loginTitle {
    return Intl.message(
      'Wellcome',
      name: 'loginTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please login with your information`
  String get loginSubTitle {
    return Intl.message(
      'Please login with your information',
      name: 'loginSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get loginUserName {
    return Intl.message(
      'User Name',
      name: 'loginUserName',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get loginPassword {
    return Intl.message(
      'Password',
      name: 'loginPassword',
      desc: '',
      args: [],
    );
  }

  /// `LOGIN`
  String get loginLogin {
    return Intl.message(
      'LOGIN',
      name: 'loginLogin',
      desc: '',
      args: [],
    );
  }

  /// `Please enter data`
  String get loginValidateMessage {
    return Intl.message(
      'Please enter data',
      name: 'loginValidateMessage',
      desc: '',
      args: [],
    );
  }

  /// `you can't send your bill`
  String get errorMessegeInPostBill {
    return Intl.message(
      'you can\'t send your bill',
      name: 'errorMessegeInPostBill',
      desc: '',
      args: [],
    );
  }

  /// `choose student`
  String get chooseStudent {
    return Intl.message(
      'choose student',
      name: 'chooseStudent',
      desc: '',
      args: [],
    );
  }

  /// `ok`
  String get ok {
    return Intl.message(
      'ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `please Choose Sell point, or check for your order list`
  String get alertPostDialog {
    return Intl.message(
      'please Choose Sell point, or check for your order list',
      name: 'alertPostDialog',
      desc: '',
      args: [],
    );
  }

  /// `cancel`
  String get cancel {
    return Intl.message(
      'cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Daily limit`
  String get threshold {
    return Intl.message(
      'Daily limit',
      name: 'threshold',
      desc: '',
      args: [],
    );
  }

  /// `balance`
  String get balance {
    return Intl.message(
      'balance',
      name: 'balance',
      desc: '',
      args: [],
    );
  }

  /// `there is an error, please try again`
  String get thereIsAnError {
    return Intl.message(
      'there is an error, please try again',
      name: 'thereIsAnError',
      desc: '',
      args: [],
    );
  }

  /// `Total: `
  String get total {
    return Intl.message(
      'Total: ',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Sell Point Account`
  String get MainTitle {
    return Intl.message(
      'Sell Point Account',
      name: 'MainTitle',
      desc: '',
      args: [],
    );
  }

  /// `Connection timeout with ApiServer`
  String get connectionTimeout {
    return Intl.message(
      'Connection timeout with ApiServer',
      name: 'connectionTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Send timeout with ApiServer`
  String get sendTimeout {
    return Intl.message(
      'Send timeout with ApiServer',
      name: 'sendTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Receive timeout with ApiServer`
  String get receiveTimeout {
    return Intl.message(
      'Receive timeout with ApiServer',
      name: 'receiveTimeout',
      desc: '',
      args: [],
    );
  }

  /// `bad response`
  String get badResponse400_13 {
    return Intl.message(
      'bad response',
      name: 'badResponse400_13',
      desc: '',
      args: [],
    );
  }

  /// `Your requesst not found, Please try later!`
  String get badResponse404 {
    return Intl.message(
      'Your requesst not found, Please try later!',
      name: 'badResponse404',
      desc: '',
      args: [],
    );
  }

  /// `internal Server error, Please try later`
  String get badResponse500 {
    return Intl.message(
      'internal Server error, Please try later',
      name: 'badResponse500',
      desc: '',
      args: [],
    );
  }

  /// `Opps There was an Error, Please try again`
  String get badResponse {
    return Intl.message(
      'Opps There was an Error, Please try again',
      name: 'badResponse',
      desc: '',
      args: [],
    );
  }

  /// `Request to  ApiServer was canceld`
  String get cancelRequest {
    return Intl.message(
      'Request to  ApiServer was canceld',
      name: 'cancelRequest',
      desc: '',
      args: [],
    );
  }

  /// `Unecpected Error, Please try later!`
  String get UnecpectedError {
    return Intl.message(
      'Unecpected Error, Please try later!',
      name: 'UnecpectedError',
      desc: '',
      args: [],
    );
  }

  /// `Please select an item`
  String get errorDialogItem {
    return Intl.message(
      'Please select an item',
      name: 'errorDialogItem',
      desc: '',
      args: [],
    );
  }

  /// `Please select a student`
  String get errorDialogStudent {
    return Intl.message(
      'Please select a student',
      name: 'errorDialogStudent',
      desc: '',
      args: [],
    );
  }

  /// `Daily limit or balance is not enough`
  String get errorDialogBalance {
    return Intl.message(
      'Daily limit or balance is not enough',
      name: 'errorDialogBalance',
      desc: '',
      args: [],
    );
  }

  /// `There is local data, upload it to the server and then inventory the items`
  String get endDayDialog {
    return Intl.message(
      'There is local data, upload it to the server and then inventory the items',
      name: 'endDayDialog',
      desc: '',
      args: [],
    );
  }

  /// `charge`
  String get charge {
    return Intl.message(
      'charge',
      name: 'charge',
      desc: '',
      args: [],
    );
  }

  /// `SP Name`
  String get spNameInshowyourBill {
    return Intl.message(
      'SP Name',
      name: 'spNameInshowyourBill',
      desc: '',
      args: [],
    );
  }

  /// `Upload students data`
  String get uploadBottonTitle {
    return Intl.message(
      'Upload students data',
      name: 'uploadBottonTitle',
      desc: '',
      args: [],
    );
  }

  /// `upload offline students order`
  String get uploadBottonDescription {
    return Intl.message(
      'upload offline students order',
      name: 'uploadBottonDescription',
      desc: '',
      args: [],
    );
  }

  /// `Click here to select a student`
  String get chargeScanBotton {
    return Intl.message(
      'Click here to select a student',
      name: 'chargeScanBotton',
      desc: '',
      args: [],
    );
  }

  /// `scan`
  String get scan {
    return Intl.message(
      'scan',
      name: 'scan',
      desc: '',
      args: [],
    );
  }

  /// `inter amount`
  String get interAmount {
    return Intl.message(
      'inter amount',
      name: 'interAmount',
      desc: '',
      args: [],
    );
  }

  /// `Recharge student cards`
  String get rechargeStudentCards {
    return Intl.message(
      'Recharge student cards',
      name: 'rechargeStudentCards',
      desc: '',
      args: [],
    );
  }

  /// `Recharge by QR`
  String get RechargeByQR {
    return Intl.message(
      'Recharge by QR',
      name: 'RechargeByQR',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure about the recharge process?`
  String get alertChargeDialog1 {
    return Intl.message(
      'Are you sure about the recharge process?',
      name: 'alertChargeDialog1',
      desc: '',
      args: [],
    );
  }

  /// `You did't choose the student or the amount`
  String get alertChargeDialog2 {
    return Intl.message(
      'You did\'t choose the student or the amount',
      name: 'alertChargeDialog2',
      desc: '',
      args: [],
    );
  }

  /// `there is no local data to upload`
  String get uploadPageMessage {
    return Intl.message(
      'there is no local data to upload',
      name: 'uploadPageMessage',
      desc: '',
      args: [],
    );
  }

  /// `there is no student choosen`
  String get thereIsNoStudentChoosen {
    return Intl.message(
      'there is no student choosen',
      name: 'thereIsNoStudentChoosen',
      desc: '',
      args: [],
    );
  }

  /// `Rest of the daily limit`
  String get RestOfTheDailyLimit {
    return Intl.message(
      'Rest of the daily limit',
      name: 'RestOfTheDailyLimit',
      desc: '',
      args: [],
    );
  }

  /// `Attention, you have requested an invoice in advance.Are you sure to send this invoice instead of those?`
  String get aleartDialogOfOrder {
    return Intl.message(
      'Attention, you have requested an invoice in advance.Are you sure to send this invoice instead of those?',
      name: 'aleartDialogOfOrder',
      desc: '',
      args: [],
    );
  }

  /// `amount taken`
  String get amountTaken {
    return Intl.message(
      'amount taken',
      name: 'amountTaken',
      desc: '',
      args: [],
    );
  }

  /// `do you want to log out from app??`
  String get exit {
    return Intl.message(
      'do you want to log out from app??',
      name: 'exit',
      desc: '',
      args: [],
    );
  }

  /// `Choose an order type`
  String get chooseAnOrderType {
    return Intl.message(
      'Choose an order type',
      name: 'chooseAnOrderType',
      desc: '',
      args: [],
    );
  }

  /// `Food Order`
  String get foodOrder {
    return Intl.message(
      'Food Order',
      name: 'foodOrder',
      desc: '',
      args: [],
    );
  }

  /// `Raw materials order`
  String get rawMaterialsOrder {
    return Intl.message(
      'Raw materials order',
      name: 'rawMaterialsOrder',
      desc: '',
      args: [],
    );
  }

  /// `there is No data`
  String get thereIsNoData {
    return Intl.message(
      'there is No data',
      name: 'thereIsNoData',
      desc: '',
      args: [],
    );
  }

  /// `returns Order`
  String get returnOrder {
    return Intl.message(
      'returns Order',
      name: 'returnOrder',
      desc: '',
      args: [],
    );
  }

  /// `expenses order`
  String get expensesOrder {
    return Intl.message(
      'expenses order',
      name: 'expensesOrder',
      desc: '',
      args: [],
    );
  }

  /// `external order`
  String get externalOrder {
    return Intl.message(
      'external order',
      name: 'externalOrder',
      desc: '',
      args: [],
    );
  }

  /// `search`
  String get search {
    return Intl.message(
      'search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `choose date`
  String get chooseDate {
    return Intl.message(
      'choose date',
      name: 'chooseDate',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
