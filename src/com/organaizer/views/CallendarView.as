/**
 * Created by Projects on 15.10.2015 г..
 */
package com.organaizer.views {

import com.organaizer.constants.C_Color;

import flash.text.TextFormat;

import starling.display.Button;

import starling.display.Button;
import starling.display.DisplayObject;

import starling.display.Image;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;

//import flash.text.TextField;

/*import fl.controls.ComboBox;
import fl.data.DataProvider;
import fl.controls.NumericStepper;*/

public class CallendarView extends BaseView
{
    //variables
    private var cellW:Number; //cell width
    private var cellP:Number; //cell padding
    private var allDatesCells:Array = new Array();
    private var dateCellFormat:TextFormat;

    private var weekDays:Array = new Array("Sun","Mon","Tue","Wed","Thu","Fri","Sat");
    private var dayLabelTxtFmt:TextFormat;

    private var currDateTime:Date = new Date();
    private var firstDay:Date = new Date(currDateTime.fullYear,currDateTime.month,1);
    private var firstDayColumn:uint = firstDay.day;
    private var daysOfMonths:Array = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
    private var maxDays:uint;

    private var months:Array = [
        {label:"January", data:0},
        {label:"February", data:1},
        {label:"March", data:2},
        {label:"April", data:3},
        {label:"May", data:4},
        {label:"June", data:5},
        {label:"July", data:6},
        {label:"August", data:7},
        {label:"September", data:8},
        {label:"October", data:9},
        {label:"November", data:10},
        {label:"December", data:11}
    ];

    //private var monthPickerCB:ComboBox; //combobox to pick a month
    //private var yearPickerNS:NumericStepper; //numeric stepper to pick a year


    public function CallendarView():void{
        super();
      //  this.visible = false;
    }

    override public function create():void
    {
        super.create();

        var fontFace:String = "Arial";
        var fontSize:int = 15;
        var cellWidth:Number = 30;
        var padding:Number = 3;
        var originX:Number = 15;
        var originY:Number = 15;
        var cbX:Number = 15;
        var cbY:Number = 15;
        var nsX:Number = 26;
        var nsY:Number = 15;
        var monthsRange:int = 39;


            cellW = cellWidth;
            cellP = padding;

            //monthPickerCB = new ComboBox();

            //yearPickerNS = new NumericStepper();



            setTextFormat( fontFace, fontSize );

            makeDatesCellGrid( originX, originY );

            makeDaysLabels( originX, originY );

            monthSetup();

            monthPicker( cbX, cbY );

            yearPicker( nsX, nsY, monthsRange );

        }



        private function setTextFormat(whichFont:String, size:int):void	{

            //date text format
            dateCellFormat = new TextFormat();
            dateCellFormat.font = whichFont;
            dateCellFormat.color = 0xFFFFFF;
            dateCellFormat.size = size;
            dateCellFormat.align = "center";

            //day label text format
            dayLabelTxtFmt = new TextFormat();
            dayLabelTxtFmt.font = "_sans";
            dayLabelTxtFmt.color = 0x000000;
            dayLabelTxtFmt.size = size - 3;
        }

        private var dateCellsSprite:Sprite;
        private var allDatesCellsBackgrounds:Array=[];

        private function makeDatesCellGrid(cellXPos:Number, cellYPos:Number):void {

            dateCellsSprite = new Sprite();

            //Create grid of date cells
            for (var i:int = 0; i < 42; i++) {

                var dayCellBackground:Button = new Button(assetManager.getTexture("icon_bg"));
                    dayCellBackground.width = cellW;
                    dayCellBackground.height = cellP;


                var dateCell:TextField = new TextField(30,30,"");
                dateCellsSprite.addChild(dateCell);

                //position cells to form a grid (7 x 6 = 42)
                dateCell.x = cellW * (i-(Math.floor(i/7)*7));
                dateCell.y = cellW * Math.floor(i/7);
                dateCell.addEventListener(TouchEvent.TOUCH, onDatePick);
                dateCell.addChild(dayCellBackground);
                //put all date cells into array for further access

                allDatesCells.push(dateCell);
                allDatesCellsBackgrounds.push(dayCellBackground);

                //layout.horizontalAlignCenter(dayCellBackground, dateCell.bounds);
                //layout.verticalAlignMiddle(dayCellBackground, dateCell.bounds);

            }

            layout.proportionWidthScale(dateCellsSprite,null,95);
            layout.horizontalAlignCenter(dateCellsSprite);
            layout.verticalAlignMiddle(dateCellsSprite);
            addChild(dateCellsSprite)
        }

        private function onDatePick(event:TouchEvent):void {

            var tf:TextField = event.currentTarget as TextField;

            if(event.getTouch(event.currentTarget as DisplayObject, TouchPhase.BEGAN)){
                     trace("Day: "+tf.text);
                     tf.color = C_Color.BATTERY_GREEN;
                //(event.currentTarget as TextField).color = C_Color.BATTERY_GREEN;
            }else if(event.getTouch(event.currentTarget as DisplayObject, TouchPhase.ENDED)){
                tf.color = C_Color.BLACK;
            }

            //trace((event.currentTarget as TextField).text)
        }

        private function makeDaysLabels(cellXPos:Number, cellYPos:Number):void {

            //Add week day names
            for (var i:int = 0; i < 7; i++)	{

                var dayLabel:TextField = new TextField(30,30,"");
                //.dayLabel.border = true;
                dateCellsSprite.addChild(dayLabel);

                //dayLabel.selectable = false;
                dayLabel.text = weekDays[i];
                //dayLabel.setTextFormat(dayLabelTxtFmt);
                dayLabel.x = cellW * i;
                dayLabel.y = cellYPos - 15 - dayLabel.height;
            }
        }

        private function monthSetup():void {

            for (var i:int = 0; i < 42; i++) {

                allDatesCells[i].text = "";

                //decor all cells
                //allDatesCells[i].background = true;
                //allDatesCells[i].backgroundColor = 0x000000;
                //allDatesCells[i].border = true;
                //allDatesCells[i].borderColor = 0xCCCCCC;
                //allDatesCells[i].selectable = false;
                allDatesCells[i].width = allDatesCells[i].height = cellW - cellP;
                //allDatesCells[i].setTextFormat(dateCellFormat);
            }

            arrangeDates();
            prevMonthDates();
            nextMonthDates();
        }

        private function arrangeDates():void {

            //get column number for first day of the month
            if (firstDay.day == 0)
            {
                //when last date of previous month is on saturday then move to second row
                firstDayColumn = firstDay.day + 7;
            }
            else
            {
                firstDayColumn = firstDay.day;
            }

            //get max days for current month w.r.t leap year if any
            maxDays = (firstDay.getFullYear()%4 == 0 && firstDay.getMonth() == 1 ? 29 : daysOfMonths[firstDay.getMonth()]);

            //put dates for current month
            for (var i:int = 0; i < maxDays; i++) {

                allDatesCells[firstDayColumn + i].text = i + 1;
               // allDatesCells[firstDayColumn + i].setTextFormat(dateCellFormat);

                allDatesCells[firstDayColumn + i].alpha = 1;

                //Highlight today
                if (firstDay.fullYear == currDateTime.fullYear && firstDay.month == currDateTime.month)
                {
                    if(allDatesCells[firstDayColumn + i].text == currDateTime.date)
                    {
                        trace("Today is: " +  allDatesCells[firstDayColumn + i].text);
                        allDatesCellsBackgrounds[firstDayColumn + i].alpha = 0;
                        //allDatesCells[firstDayColumn + i].backgroundColor = 0xEE5D15;
                    }
                }
            }
        }

        private function prevMonthDates():void {

            var prevMonthFirstDay:Date = new Date(firstDay.fullYear,firstDay.month,firstDay.date - 1);

            for (var i:int = firstDayColumn-1; i >= 0; i--) {

                allDatesCells[i].text = prevMonthFirstDay.date - ((firstDayColumn - 1) - i);
               // allDatesCells[i].setTextFormat(dateCellFormat);
                allDatesCells[i].alpha = 0.5;
            }
        }

        private function nextMonthDates():void {

            for (var i:int = 1; i < (42 - maxDays - (firstDayColumn - 1)); i++){

                allDatesCells[(firstDayColumn - 1) + i + maxDays].text = i;
                //allDatesCells[(firstDayColumn - 1) + i + maxDays].setTextFormat(dateCellFormat);
                allDatesCells[(firstDayColumn - 1) + i + maxDays].alpha = 0.5;
            }
        }

        private function monthPicker(cbX:Number, cbY:Number):void {

    /*
            monthPickerCB.dataProvider = new DataProvider(months);
            addChild(monthPickerCB);

            //position combobox
            monthPickerCB.x = cbX;
            monthPickerCB.y = (cellW * 6) + cbY;

            monthPickerCB.selectedIndex = currDateTime.month;

            monthPickerCB.addEventListener(Event.CHANGE, pickMonth);
            */
        }

        private function pickMonth(e:Event):void {

            //firstDay.month = ComboBox(e.target).selectedItem.data;
            monthSetup();
        }

        private function yearPicker(nsX:Number, nsY:Number, maxYrsRange:int):void {

    /*
            yearPickerNS.maximum = currDateTime.fullYear + maxYrsRange;
            yearPickerNS.minimum = currDateTime.fullYear - maxYrsRange;
            yearPickerNS.value = currDateTime.fullYear;
            addChild(yearPickerNS);

            //position numeric stepper
            yearPickerNS.x = monthPickerCB.width + nsX;
            yearPickerNS.y = (cellW * 6) + nsY;

            yearPickerNS.addEventListener(Event.CHANGE, pickYear);
            */
        }

        private function pickYear(e:Event):void	{

            //firstDay.fullYear = e.target.value;
            monthSetup();
        }
    }
}