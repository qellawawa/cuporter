require 'spec_helper'

module Cuporter

  describe "Single Feature Tag Reports" do

    context "one scenario one tag" do
      it "returns one tag mapped to one scenario name" do
        report = one_feature( "fixtures/one_scenario_one_tag.feature")
        report.should == <<EOF
  @wip
    Feature: foo
      Scenario: bar the great foo
EOF
      end
    end

    context "one scenario two tags" do
      it "returns two tags mapped to the same scenario" do
        report = one_feature( "fixtures/one_scenario_two_tags.feature")
        report.should  == <<EOF
  @smoke
    Feature: foo
      Scenario: some test of something
  @wip
    Feature: foo
      Scenario: some test of something
EOF
      end
    end

    context "two scenarios one tag" do
      it "returns one tag mapped to one scenario" do
        report = one_feature( "fixtures/two_scenarios_one_tag.feature")
        report.should == <<EOF
  @smoke
    Feature: foo
      Scenario: another test
EOF
      end
    end

    context "difficult input: the apostrophe" do

      it "raises no error if a cuke name has a single quote" do
        report = ""
        expect do
          report = one_feature("fixtures/apostrophe.feature")
        end.to_not raise_error
        report.should == <<EOF
  @apostrophe
    Feature: What's the point of it all, Charlie?
      Scenario: I sport an apostrophe this evening, Sir!
  @encoding
    Feature: What's the point of it all, Charlie?
      Scenario: I sport an apostrophe this evening, Sir!
EOF
      end
    end

  end
end

