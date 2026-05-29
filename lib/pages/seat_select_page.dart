import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sitdown/api/seat_api.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/providers/auth_provider.dart';
import 'package:sitdown/pages/seat_info_page.dart';
import 'package:sitdown/widgets/common/chevron_left.dart';

class SeatSelectPage extends StatefulWidget {
  final String spaceId;
  final String spaceName;
  final int? floor;

  const SeatSelectPage({
    super.key,
    required this.spaceId,
    required this.spaceName,
    this.floor,
  });

  @override
  State<SeatSelectPage> createState() => _SeatSelectPageState();
}

class _SeatSelectPageState extends State<SeatSelectPage> {
  bool isLoading = true;

  int seatRows = 0;
  int seatColumns = 0;

  List<Map<String, dynamic>> seatList = [];
  Map<String, dynamic>? selectedSeat;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getSeats();
    });
  }

  Future<void> getSeats() async {
    final accessToken = context.read<AuthProvider>().accessToken;

    if (accessToken == null || accessToken.isEmpty) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('로그인이 필요합니다.')));
      return;
    }

    try {
      final response = await SeatApi.getSeats(
        accessToken: accessToken,
        spaceId: widget.spaceId,
      );

      print('좌석 조회 응답: $response');

      setState(() {
        seatRows = response['rows'] ?? 0;
        seatColumns = response['columns'] ?? 0;

        seatList = List<Map<String, dynamic>>.from(response['seats'] ?? []);

        seatList.sort((a, b) {
          final rowA = int.tryParse(a['row'].toString()) ?? 0;
          final rowB = int.tryParse(b['row'].toString()) ?? 0;
          final columnA = int.tryParse(a['column'].toString()) ?? 0;
          final columnB = int.tryParse(b['column'].toString()) ?? 0;

          if (rowA != rowB) return rowA.compareTo(rowB);
          return columnA.compareTo(columnB);
        });

        isLoading = false;
      });
    } catch (e) {
      print('좌석 조회 에러: $e');

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('좌석 정보를 불러오지 못했습니다.')));
    }
  }

  Color getSeatColor(String status, bool isSelected) {
    if (isSelected) return primaryColor;

    if (status == 'AVAILABLE') return const Color(0xFF8FD19E);
    if (status == 'OCCUPIED') return const Color(0xFFFF6B75);
    if (status == 'RESERVED') return const Color(0xFFFF6B75);
    if (status == 'UNAVAILABLE') return const Color(0xFFD6D6D8);

    return const Color(0xFFD6D6D8);
  }

  void selectSeat(Map<String, dynamic> seat) {
    print('선택한 좌석 전체 정보: $seat');

    final status = seat['status']?.toString() ?? '';

    if (status != 'AVAILABLE') {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('선택할 수 없는 좌석입니다.')));
      return;
    }

    setState(() {
      selectedSeat = seat;
    });
  }

  void goNext() {
    if (selectedSeat == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('좌석을 선택해 주세요.')));
      return;
    }

    final seatId = selectedSeat!['id']?.toString() ?? '';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SeatInfoPage(
          seatId: seatId,
          spaceName: widget.spaceName,
          floor: widget.floor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final floorText = widget.floor == null ? '' : ' (${widget.floor}층)';

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(color: primaryColor),
              )
            : Padding(
                padding: const EdgeInsets.fromLTRB(30, 28, 30, 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    chevron_left(
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),

                    const SizedBox(height: 16),

                    Text(
                      '${widget.spaceName}$floorText',
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF111827),
                      ),
                    ),

                    const SizedBox(height: 18),

                    Text(
                      '${seatRows}행 × ${seatColumns}열',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF5B6475),
                      ),
                    ),

                    const SizedBox(height: 44),

                    _SeatMap(
                      rows: seatRows,
                      columns: seatColumns,
                      seats: seatList,
                      selectedSeatId: selectedSeat?['id']?.toString(),
                      getSeatColor: getSeatColor,
                      onSelectSeat: selectSeat,
                    ),

                    const Spacer(),

                    const _SeatLegend(),

                    const SizedBox(height: 58),

                    SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: ElevatedButton(
                        onPressed: goNext,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: whiteColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          '다음',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class _SeatMap extends StatelessWidget {
  final int rows;
  final int columns;
  final List<Map<String, dynamic>> seats;
  final String? selectedSeatId;
  final Color Function(String status, bool isSelected) getSeatColor;
  final void Function(Map<String, dynamic> seat) onSelectSeat;

  const _SeatMap({
    required this.rows,
    required this.columns,
    required this.seats,
    required this.selectedSeatId,
    required this.getSeatColor,
    required this.onSelectSeat,
  });

  Map<String, dynamic>? findSeat(int row, int column) {
    for (final seat in seats) {
      final seatRow = int.tryParse(seat['row'].toString()) ?? 0;
      final seatColumn = int.tryParse(seat['column'].toString()) ?? 0;

      if (seatRow == row && seatColumn == column) {
        return seat;
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final safeRows = rows <= 0 ? 1 : rows;
    final safeColumns = columns <= 0 ? 1 : columns;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 38),
          child: Row(
            children: List.generate(safeColumns, (index) {
              final columnNumber = index + 1;

              return Expanded(
                child: Center(
                  child: Text(
                    '$columnNumber',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF5B6475),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),

        const SizedBox(height: 20),

        Column(
          children: List.generate(safeRows, (rowIndex) {
            final rowNumber = rowIndex + 1;

            return Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Row(
                children: [
                  SizedBox(
                    width: 28,
                    child: Text(
                      '$rowNumber',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF5B6475),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Row(
                      children: List.generate(safeColumns, (columnIndex) {
                        final columnNumber = columnIndex + 1;
                        final seat = findSeat(rowNumber, columnNumber);

                        if (seat == null) {
                          return const Expanded(child: SizedBox());
                        }

                        final seatId = seat['id']?.toString() ?? '';
                        final label = seat['label']?.toString() ?? '';
                        final status = seat['status']?.toString() ?? '';
                        final isSelected = selectedSeatId == seatId;

                        return Expanded(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                print('좌석 클릭됨: $seat');
                                onSelectSeat(seat);
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: SizedBox(
                                height: 44,
                                child: Center(
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 150),
                                    width: isSelected ? 76 : 30,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: getSeatColor(status, isSelected),
                                      borderRadius: BorderRadius.circular(
                                        isSelected ? 8 : 5,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.08),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: isSelected
                                        ? Text(
                                            label,
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w900,
                                              color: whiteColor,
                                            ),
                                          )
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _SeatLegend extends StatelessWidget {
  const _SeatLegend();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _LegendItem(color: Color(0xFF8FD19E), text: '사용 가능'),
        _LegendItem(color: Color(0xFFFF6B75), text: '사용 중'),
        _LegendItem(color: Color(0xFFD6D6D8), text: '선택 불가'),
        _LegendItem(color: primaryColor, text: '선택 좌석'),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const _LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 7),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            color: Color(0xFF5B6475),
          ),
        ),
      ],
    );
  }
}
