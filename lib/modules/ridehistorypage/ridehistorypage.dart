import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uberapp/modules/ridehistorypage/cubit/ride_history_cubit.dart';
import 'package:intl/intl.dart';

class RideHistoryPage extends StatelessWidget {
  const RideHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RideHistoryCubit, RideHistoryState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = RideHistoryCubit.get(context);
        return Scaffold(
          appBar: AppBar(title: Center(child: Text('Ride History'))),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if(state is GetRidesLoadingState)
                  CircularProgressIndicator(),
                  
                  if(cubit.rides == [])
                  Text('No Rides'),

                  if(state is GetRidesSuccessState)
                  ListView.separated(
                    shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[200],
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(.05),
                                    spreadRadius: 3,
                                    blurRadius: 3)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 3,
                                    ),
                                    CircleAvatar(
                                      radius: 7,
                                      backgroundColor: Colors.grey[900],
                                    ),
                                    Container(
                                      height: 140,
                                      width: 3,
                                      color: Colors.grey[900],
                                    ),
                                    CircleAvatar(
                                      radius: 7,
                                      backgroundColor: Colors.grey[900],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: Text(cubit.rides![index].from!,
                                              maxLines: 2)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(DateFormat('yyyy-MM-dd hh:mm a').format(cubit.rides![index].date!)),
                                      Text(cubit.rides![index].type!),
                                      Text(cubit.rides![index].price!),
                                      Spacer(),
                                      Expanded(
                                        child: Text(
                                            cubit.rides![index].to!),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                      itemCount: cubit.rides!.length)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
