import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_manager/controller/meal_controller.dart';
import 'package:meal_manager/model/meal_model.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

class DecoratedTablePage extends GetView<MealController> {
  DecoratedTablePage({
    required this.data,
    required this.titleColumn,
    required this.titleRow,
  });

  final List<List<String>> data;
  final List<String> titleColumn; // name of all member
  final List<String> titleRow; //

  var isHorizontalScrollbar = false;
  var isVerticalScrollbar = false;

  List<NameModel> allData = MealController.to.getAllMealdayData;

  // GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
  //     GlobalKey<RefreshIndicatorState>();

  //List<NameModel> allData = MealController.to.getAllMealdayData;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Member Meals',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StickyHeadersTable(
              columnsLength: titleColumn.length,
              rowsLength: titleRow.length,
              columnsTitleBuilder: (i) {
                return Column(
                  children: [
                    TableCell.stickyRow(
                      titleColumn[i],
                    ),
                    Row(
                      children: [
                        TableCell.content('B.fast'),
                        TableCell.content('Lunch'),
                        TableCell.content('Dinner'),
                      ],
                    ),
                  ],
                );
              },
              rowsTitleBuilder: (i) => TableCell.stickyColumn(
                titleRow[i],
              ),
              contentCellBuilder: (i, date) {
                // date is the j value,, i == person index value
                int personIndex = i;
                date++;
                int bela = 0; // sokal,dupur,dinner

                String person = titleColumn[personIndex]; // person name

                String sokalV =
                    allData[personIndex].day![date].sokal.toString();
                String lunchV =
                    allData[personIndex].day![date].lunch.toString();
                String dinnerV =
                    allData[personIndex].day![date].dinner.toString();

                return Row(
                  children: [
                    TableCell.content(sokalV == 'null' ? '' : sokalV),
                    TableCell.content(lunchV == 'null' ? '' : lunchV),
                    TableCell.content(dinnerV == 'null' ? '' : dinnerV),
                  ],
                );
              },
              legendCell: Column(
                children: [
                  TableCell.legend(
                    'Name',
                  ),
                  TableCell.legend(
                    'Date',
                  ),
                ],
              ),
              showVerticalScrollbar: isVerticalScrollbar,
              showHorizontalScrollbar: isHorizontalScrollbar,
              cellDimensions: const CellDimensions.fixed(
                  contentCellWidth: 210,
                  contentCellHeight: 30,
                  stickyLegendWidth: 60,
                  stickyLegendHeight: 100),

              //cellDimensions:  CellDimensions.variableColumnWidthAndRowHeight(columnWidths: [100], rowHeights: [30], stickyLegendWidth: 50, stickyLegendHeight: 30),
            ),
          ),
        ],
      ),
    );
  }
}

class TableCell extends StatelessWidget {
  final CellDimensions cellDimensions;

  final String text;
  final Function()? onTap;

  final double? cellWidth;
  final double? cellHeight;

  final Color colorBg;
  final Color _colorHorizontalBorder;
  final Color _colorVerticalBorder;

  final TextAlign _textAlign;
  final EdgeInsets _padding;

  final TextStyle? textStyle;

  TableCell.content(
    this.text, {
    this.textStyle,
    this.cellDimensions = CellDimensions.base,
    this.colorBg = Colors.white,
    this.onTap,
  })  : cellWidth = 70,
        cellHeight = cellDimensions.contentCellHeight,
        _colorHorizontalBorder = Colors.green,
        _colorVerticalBorder = Colors.black38,
        _textAlign = TextAlign.center,
        _padding = EdgeInsets.zero;

  TableCell.legend(
    this.text, {
    this.textStyle,
    this.cellDimensions = CellDimensions.base,
    this.colorBg = Colors.amber,
    this.onTap,
  })  : cellWidth = cellDimensions.stickyLegendWidth,
        cellHeight = cellDimensions.stickyLegendHeight,
        _colorHorizontalBorder = Colors.white,
        _colorVerticalBorder = Colors.amber,
        _textAlign = TextAlign.start,
        _padding = EdgeInsets.zero;

  TableCell.stickyRow(
    this.text, {
    this.textStyle,
    this.cellDimensions = CellDimensions.base,
    this.colorBg = Colors.amber,
    this.onTap,
  })  : cellWidth = 210,
        cellHeight = cellDimensions.stickyLegendHeight,
        _colorHorizontalBorder = Colors.white,
        _colorVerticalBorder = Colors.amber,
        _textAlign = TextAlign.center,
        _padding = EdgeInsets.zero;

  TableCell.stickyColumn(
    this.text, {
    this.textStyle,
    this.cellDimensions = CellDimensions.base,
    this.colorBg = Colors.white,
    this.onTap,
  })  : cellWidth = cellDimensions.stickyLegendWidth,
        cellHeight = cellDimensions.contentCellHeight,
        _colorHorizontalBorder = Colors.amber,
        _colorVerticalBorder = Colors.black38,
        _textAlign = TextAlign.start,
        _padding = EdgeInsets.only(left: 0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cellWidth,
        height: cellHeight,
        // padding: _padding,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 2.0),
                child: Text(
                  text,
                  style: textStyle,
                  maxLines: 2,
                  textAlign: _textAlign,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 1.1,
              color: _colorVerticalBorder,
            ),
          ],
        ),
        decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: _colorHorizontalBorder),
              right: BorderSide(color: _colorHorizontalBorder),
            ),
            color: colorBg),
      ),
    );
  }
}
